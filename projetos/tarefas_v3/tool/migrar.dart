
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> argumentos) async {
  var arquivo = File('lib/database/banco_dados.dart');
  var pasta = Directory('drift_schemas/path');

  if (!await arquivo.exists()) {
    print('Arquivo do banco não encontrado!');
    exit(1);
  }

  if (!await pasta.exists()) {
    print('Pasta de snapshots não encontrada!');
    exit(1);
  }

  var codigoOriginal = await arquivo.readAsString();
  var regexVersao = RegExp(
    r'int get schemaVersion\s*=>\s*(\d+)\s*;',
  );

  var resultado = regexVersao.firstMatch(codigoOriginal);

  if (resultado == null) {
    print('schemaVersion não encontrado!');
    exit(1);
  }

  var versaoAtual = int.parse(resultado.group(1)!);

  var snapshots = <int, Map<String, dynamic>>{};

  for (var versao = 1; versao <= versaoAtual; versao++) {
    var arquivoSchema = File(
      '${pasta.path}/drift_schema_v$versao.json',
    );

    if (!await arquivoSchema.exists()) {
      print('Snapshot da versão $versao não encontrado!');
      exit(1);
    }

    snapshots[versao] =
        jsonDecode(await arquivoSchema.readAsString());
  }

  // Comparamos o código atual com o último snapshot.
  // Se não existem colunas novas, não aumentamos a versão.
  var colunasAtuais = descobrirColunasAtuais(codigoOriginal);
  var colunasSnapshot = obterColunas(snapshots[versaoAtual]!);

  var novas = colunasAtuais.difference(colunasSnapshot);

  var excluidas = colunasSnapshot.difference(colunasAtuais);

  if (excluidas.isNotEmpty) {
    print('Foram detectadas colunas removidas ou renomeadas.');
    print('Essa alteração precisa de uma migração específica.');
    exit(1);
  }

  var alterouVersao = novas.isNotEmpty;
  var novaVersao = versaoAtual;

  if (alterouVersao) {
    novaVersao++;

    print('Novas colunas encontradas:');
    for (var coluna in novas) {
      print('  $coluna');
    }

    var novoCodigo = codigoOriginal.replaceFirst(
      regexVersao,
      'int get schemaVersion => $novaVersao;',
    );

    await arquivo.writeAsString(novoCodigo);

    print('Versão atualizada: $versaoAtual -> $novaVersao');

    var compilacao = await executar([
      'run',
      'build_runner',
      'build',
    ]);

    if (compilacao != 0) {
      await arquivo.writeAsString(codigoOriginal);
      print('Erro ao gerar o código do Drift!');
      exit(1);
    }

    var migracao = await executar([
      'run',
      'drift_dev',
      'make-migrations',
    ]);

    if (migracao != 0) {
      await arquivo.writeAsString(codigoOriginal);
      print('Erro ao gerar migrações!');
      exit(1);
    }

    var novoSnapshot = File(
      '${pasta.path}/drift_schema_v$novaVersao.json',
    );

    if (!await novoSnapshot.exists()) {
      await arquivo.writeAsString(codigoOriginal);
      print('Snapshot novo não foi gerado!');
      exit(1);
    }

    snapshots[novaVersao] =
        jsonDecode(await novoSnapshot.readAsString());
  } else {
    print('Nenhuma coluna nova encontrada.');
    print('Mantendo schemaVersion => $versaoAtual');
  }

  // Reconstruímos todas as etapas usando os snapshots.
  // Assim, se uma coluna apareceu na versão 2,
  // ela será adicionada em from1To2, e não em from2To3.
  var etapas = <String>[];

  for (var versao = 1; versao < novaVersao; versao++) {
    var anterior = snapshots[versao]!;
    var proximo = snapshots[versao + 1]!;

    var colunasAntes = obterColunas(anterior);
    var colunasDepois = obterColunas(proximo);

    var adicionadas = colunasDepois.difference(colunasAntes);
    var removidas = colunasAntes.difference(colunasDepois);

    if (removidas.isNotEmpty) {
      print('A versão ${versao + 1} remove colunas.');
      print('Não é seguro automatizar essa alteração.');
      exit(1);
    }

    var operacoes = <String>[];

    for (var coluna in adicionadas) {
      var partes = coluna.split('.');
      var tabela = partes[0];
      var nomeColuna = partes[1];

      operacoes.add(
        'await m.addColumn('
        'schema.$tabela, '
        'schema.$tabela.$nomeColuna);',
      );
    }

    var corpo = operacoes.join('\n        ');

    etapas.add('''
      from${versao}To${versao + 1}: (m, schema) async {
        $corpo
      },
''');
  }

  var codigoBanco = await arquivo.readAsString();

  // Localizamos o getter migration inteiro.
  // Isso permite criar o primeiro stepByStep
  // ou corrigir um que já existe.
  var regexMigration = RegExp(
    r'MigrationStrategy\s+get\s+migration\s*\{',
  );

  var encontrado = regexMigration.firstMatch(codigoBanco);

  if (encontrado == null) {
    print('MigrationStrategy não encontrada!');
    exit(1);
  }

  var inicio = encontrado.start;
  var abertura = codigoBanco.indexOf('{', encontrado.start);
  var nivel = 0;
  var fim = -1;

  for (var i = abertura; i < codigoBanco.length; i++) {
    if (codigoBanco[i] == '{') {
      nivel++;
    } else if (codigoBanco[i] == '}') {
      nivel--;

      if (nivel == 0) {
        fim = i + 1;
        break;
      }
    }
  }

  if (fim == -1) {
    print('Não foi possível localizar o fim da migration!');
    exit(1);
  }

  var textoEtapas = etapas.join('\n');

  var novaMigration = '''
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    ${etapas.isEmpty ? '' : '''
    onUpgrade: stepByStep(
$textoEtapas
    ),
    '''}
  );
}
''';

  codigoBanco = codigoBanco.substring(0, inicio) +
      novaMigration +
      codigoBanco.substring(fim);

  // Adicionamos o import do arquivo de migrações
  // somente quando existem etapas para executar.
  if (etapas.isNotEmpty &&
      !codigoBanco.contains("import 'banco_dados.steps.dart';")) {
    codigoBanco = codigoBanco.replaceFirst(
      "part 'banco_dados.g.dart';",
      "import 'banco_dados.steps.dart';\n\n"
      "part 'banco_dados.g.dart';",
    );
  }

  await arquivo.writeAsString(codigoBanco);

  var formato = await executar([
    'format',
    arquivo.path,
  ]);

  if (formato != 0) {
    print('Erro ao formatar o código!');
    exit(1);
  }

  print('stepByStep atualizado automaticamente!');

  // O arquivo com data e hora só é criado
  // quando realmente existe uma versão nova.
  if (alterouVersao) {
    var nome = argumentos.isNotEmpty
        ? argumentos.join('_').toLowerCase()
        : 'migracao';

    nome = nome.replaceAll(
      RegExp(r'[^a-z0-9_]+'),
      '_',
    );

    var agora = DateTime.now();

    var timestamp =
        '${agora.year}'
        '${agora.month.toString().padLeft(2, '0')}'
        '${agora.day.toString().padLeft(2, '0')}'
        '${agora.hour.toString().padLeft(2, '0')}'
        '${agora.minute.toString().padLeft(2, '0')}'
        '${agora.second.toString().padLeft(2, '0')}';

    var pastaMigracoes = Directory('migrations');

    await pastaMigracoes.create(recursive: true);

    var arquivoMigracao = File(
      '${pastaMigracoes.path}/m_${timestamp}_${nome}.dart',
    );

    await arquivoMigracao.writeAsString('''
// Migração: $nome
// Criada em: ${agora.toIso8601String()}
// Versão: $versaoAtual -> $novaVersao
// Registro da migração gerada no banco_dados.dart
''');

    print('Registro criado: ${arquivoMigracao.path}');
  }

  print('Processo finalizado!');
}

// Executa comandos Dart e mostra as mensagens no terminal.
Future<int> executar(List<String> argumentos) async {
  var processo = await Process.start(
    'dart',
    argumentos,
    mode: ProcessStartMode.inheritStdio,
  );

  return await processo.exitCode;
}

// Lê as colunas do banco diretamente dos snapshots do Drift.
Set<String> obterColunas(Map<String, dynamic> snapshot) {
  var colunas = <String>{};

  var entidades = snapshot['entities'] as List<dynamic>;

  for (var entidade in entidades) {
    if (entidade['type'] != 'table') {
      continue;
    }

    var dados = entidade['data'];
    var nomeTabela = dados['name'].toString();

    var nomeNoDart = nomeTabela.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (resultado) => resultado.group(1)!.toUpperCase(),
    );

    for (var coluna in dados['columns']) {
      var nomeColuna = coluna['getter_name'].toString();

      colunas.add('$nomeNoDart.$nomeColuna');
    }
  }

  return colunas;
}

// Descobre quais colunas estão declaradas no Dart.
Set<String> descobrirColunasAtuais(String codigo) {
  var colunas = <String>{};

  var regexTabela = RegExp(
    r'class\s+(\w+)\s+extends\s+Table\s*\{([\s\S]*?)\n\}',
  );

  var regexColuna = RegExp(
    r'\w+Column\s+get\s+(\w+)\s*=>',
  );

  for (var tabela in regexTabela.allMatches(codigo)) {
    var nomeTabela = tabela.group(1)!;

    var nomeNoDart =
        nomeTabela[0].toLowerCase() + nomeTabela.substring(1);

    var conteudoTabela = tabela.group(2)!;

    for (var coluna in regexColuna.allMatches(conteudoTabela)) {
      colunas.add('$nomeNoDart.${coluna.group(1)!}');
    }
  }

  return colunas;
}
