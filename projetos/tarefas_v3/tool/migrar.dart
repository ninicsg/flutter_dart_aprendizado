import 'dart:io';
// Essa é a função principal onde o programa começa
// O Future<void> fala que vamos ter operações assincronas
// e o async permite usar o await
Future<void> main(List<String> argumentos) async {
    // aq estamos dizendo qual arquivo queremos modificar
  // Nesse caso é o arquivo onde ta o schemaVersion do drift
  var arquivo = File('lib/database/banco_dados.dart');
  // Primeiro verificamos se esse arquivo realmente existe
  // O await espera essa verificação terminar
  if (!await arquivo.exists()) {
    // Se não encontrar o arquivo, mostramos essa mensagem.
    print('Arquivo do banco não encontrado!');
    // Encerra o programa com código 1, que deu erro.
    exit(1);
  }

  // Aqui lemos todo o conteúdo do arquivo banco_dados.dart
  // pegamos todo o codigo dele e guardamos dentro da variável conteudo como uma string
  var conteudo = await arquivo.readAsString();
  // Essa parte serve para encontrar o schemaVersion no código.
  // O RegExp permite procurar um texto seguindo um padrão.
  // Por exemplo, ele consegue encontrar:
  // int get schemaVersion => 3;
  // O \s* aceita espaços, mesmo que não tenha nenhum.
  // O \d+ encontra um ou mais números.
  // Os parênteses em (\d+) permitem pegar só o número depois.
  var regex = RegExp(r'int get schemaVersion\s*=>\s*(\d+)\s*;');
  // Aqui procuramos no conteúdo do arquivo alguma parte
  // que corresponda ao padrão que criamos acima.
  var resultado = regex.firstMatch(conteudo);

  if (resultado == null) {
    print('schemaVersion não encontrado!');
    exit(1);
  }
  // Aqui pegamos o número que encontramos no schemaVersion.
  // O group(1) pega o número que estava entre parênteses
  // na expressão regular, por exemplo "3".
  // O int.parse transforma esse texto "3" no número inteiro 3.
  // O ! indica que estamos afirmando que esse valor não é null.
  var versaoAtual = int.parse(resultado.group(1)!);
  // Agora aumentamos a versão em 1
  var novaVersao = versaoAtual + 1;
  var colunasNovas = await descobrirColunas(arquivo);

  if (colunasNovas.isEmpty) {
    print('Nenhuma coluna nova encontrada!');
    exit(1);
  }
  var nome = argumentos.isNotEmpty
      ? argumentos.join('_').toLowerCase()
      : 'migracao';

  nome = nome.replaceAll(RegExp(r'[^a-z0-9_]+'), '_');

  var agora = DateTime.now();

  var timestamp =
      '${agora.year}'
      '${agora.month.toString().padLeft(2, '0')}'
      '${agora.day.toString().padLeft(2, '0')}'
      '${agora.hour.toString().padLeft(2, '0')}'
      '${agora.minute.toString().padLeft(2, '0')}'
      '${agora.second.toString().padLeft(2, '0')}';

  // Aqui vamos substituir a versão antiga pela nova
  // dentro do conteúdo que lemos do arquivo.
  conteudo = conteudo.replaceFirst(
    // Esse é o padrão que queremos encontrar e substituir.
    regex,
    // Esse é o texto novo que vai entrar no lugar.
    // O $ permite colocar o valor da variável dentro da String.
    // Antes: int get schemaVersion => 3;
    // Depois: int get schemaVersion => 4;
    'int get schemaVersion => $novaVersao',
  );
  // Até agora, só alteramos o texto que está na memória.
  // Aqui realmente salvamos o novo conteúdo no arquivo.
  await arquivo.writeAsString(conteudo);
  // Mostramos no terminal qual era a versão antiga
  // e para qual versão ela foi atualizada.
  //
  // Exemplo: Versão atualizada: 3 -> 4
  print('Versão atualizada: $versaoAtual -> $novaVersao');
  // Agora vamos executar um comando do Drift automaticamente
  // O Process.start permite executar programas pelo Dart
  // como se estivéssemos digitando comandos no terminal
  var processo = await Process.start(
    // Esse é o programa que queremos executar
    'dart',
    // Esses são os argumentos que passamos para ele
    // Juntando tudo, o comando executado será
    // dart run drift_dev make-migrations
    // Esse comando gera os arquivos auxiliares
    // para trabalhar com as migrações do banco
    ['run', 'drift_dev', 'make-migrations'],
    // Isso faz com que as mensagens do comando apareçam
    // diretamente no nosso terminal.
    //
    // Assim conseguimos acompanhar o que o Drift está fazendo.
    mode: ProcessStartMode.inheritStdio,
  );
  // Aqui esperamos o comando do Drift terminar.
  //
  // Quando termina, ele devolve um código.
  //
  // 0 significa que deu tudo certo.
  // Qualquer outro número indica algum erro.
  var codigo = await processo.exitCode;

  // Verificamos se o comando terminou com erro.
  if (codigo != 0) {
    print('Erro ao gerar migrações!');
    exit(codigo);
  }

  var pasta = Directory('migrations');

  if (!await pasta.exists()) {
    await pasta.create(recursive: true);
  }

  var migracao = File(
    '${pasta.path}/${timestamp}_${nome}.dart',
  );

  await migracao.writeAsString('''
  // Migração: $nome
  // Criada em: ${agora.toIso8601String()}
  // Versão: $versaoAtual -> $novaVersao

  // from${versaoAtual}To$novaVersao: (m, schema) async {
  //
  // },
  ''');

  print('Migração criada: ${migracao.path}');

  print('Arquivos de migração gerados!');

    // Aqui lemos novamente o arquivo do banco,
    // agora com o schemaVersion atualizado.
    var codigoBanco = await arquivo.readAsString();

    // Montamos o nome da nova migração.
    // Exemplo: from3To4
    var nomeMigracao = 'from${versaoAtual}To$novaVersao';

    // Verificamos se essa migração já existe no arquivo,
    // para não criar duas vezes a mesma função.
    if (codigoBanco.contains('$nomeMigracao:')) {
    print('Essa migração já existe!');
    return;
    }

    // Aqui montamos o código que será adicionado no stepByStep.
    var operacoes = colunasNovas.join('\n      ');

    var novaMigracao = '''
        $nomeMigracao: (m, schema) async {
        $operacoes
        },
    ''';

    // Procuramos onde começa o stepByStep.
    var inicio = codigoBanco.indexOf('stepByStep(');

    if (inicio == -1) {
    print('stepByStep não encontrado!');
    exit(1);
    }

    // Procuramos o fechamento do stepByStep,
    // considerando os parênteses das funções internas.
    var nivel = 0;
    var fim = -1;

    for (var i = inicio + 'stepByStep'.length;
        i < codigoBanco.length;
        i++) {
    if (codigoBanco[i] == '(') {
        nivel++;
    } else if (codigoBanco[i] == ')') {
        nivel--;

        if (nivel == 0) {
        fim = i;
        break;
        }
    }
    }

    if (fim == -1) {
    print('Não foi possível encontrar o fim do stepByStep!');
    exit(1);
    }

    // Adicionamos a nova migração antes do fechamento.
    codigoBanco = codigoBanco.substring(0, fim) +
        novaMigracao +
        codigoBanco.substring(fim);

    // Salvamos o arquivo com a migração adicionada.
    await arquivo.writeAsString(codigoBanco);

    print('Migração $nomeMigracao adicionada automaticamente!');
}

Future<List<String>> descobrirColunas(File arquivo) async {
  var resultado = await Process.run(
    'git',
    ['show', 'HEAD:${arquivo.path}'],
  );

  if (resultado.exitCode != 0) {
    throw Exception(
      'Não foi possível encontrar a versão anterior no Git.',
    );
  }

  var codigoAntigo = resultado.stdout.toString();
  var codigoAtual = await arquivo.readAsString();

  var regexTabela = RegExp(
    r'class\s+(\w+)\s+extends\s+Table\s*\{([\s\S]*?)\n\}',
  );

  var regexColuna = RegExp(
    r'\w+Column\s+get\s+(\w+)\s*=>',
  );

  var tabelasAntigas = <String, Set<String>>{};

  for (var tabela in regexTabela.allMatches(codigoAntigo)) {
    var nomeTabela = tabela.group(1)!;
    var colunas = <String>{};

    for (var coluna in regexColuna.allMatches(tabela.group(2)!)) {
      colunas.add(coluna.group(1)!);
    }

    tabelasAntigas[nomeTabela] = colunas;
  }

  var colunasNovas = <String>[];

  for (var tabela in regexTabela.allMatches(codigoAtual)) {
    var nomeTabela = tabela.group(1)!;

    if (!tabelasAntigas.containsKey(nomeTabela)) {
      continue;
    }

    var nomeNoSchema =
        nomeTabela[0].toLowerCase() + nomeTabela.substring(1);

    for (var coluna in regexColuna.allMatches(tabela.group(2)!)) {
      var nomeColuna = coluna.group(1)!;

      if (!tabelasAntigas[nomeTabela]!.contains(nomeColuna)) {
        colunasNovas.add(
          'await m.addColumn(schema.$nomeNoSchema, '
          'schema.$nomeNoSchema.$nomeColuna);',
        );
      }
    }
  }

  return colunasNovas;
}
