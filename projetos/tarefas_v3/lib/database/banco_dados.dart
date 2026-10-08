import 'package:drift/drift.dart';

import 'package:drift_flutter/drift_flutter.dart';


part 'banco_dados.g.dart';

class Tarefas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get descricao => text().withLength(min: 1, max: 42)();

  BoolColumn get teste3 => boolean().withDefault(const Constant(false))();

  BoolColumn get teste33 => boolean().withDefault(const Constant(false))();

  TextColumn get testeMigracao => text().nullable()();

}

@DriftDatabase(tables: [Tarefas])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'tarefas_db',
              web: DriftWebOptions(
                // Necessário para o banco funcionar na web também
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );

  @override
  int get schemaVersion => 1;
  // Esse número deve ser aumentado manualmente

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }
}

// @DriftDatabase informa ao Drift quais tabelas pertencem ao nosso banco.
// Neste caso, o banco possui a tabela Tarefas.
//
// AppDatabase é a classe que representa o nosso banco de dados dentro do Dart.
//
// _$AppDatabase é uma classe gerada automaticamente pelo Drift no arquivo
// banco_dados.g.dart. Nós escrevemos AppDatabase e o Drift gera a parte que
// falta.
//
// O construtor AppDatabase() é executado quando fazemos:
// AppDatabase()
//
// O parâmetro opcional executor existe para que os testes de migration possam
// passar um banco de teste. No aplicativo, usamos AppDatabase() normalmente.
//
// A parte super(...) chama o construtor da classe pai, que é _$AppDatabase.
// Dentro dele passamos driftDatabase(name: 'tarefas_db'), que configura a
// conexão com o banco SQLite.
//
// O nome 'tarefas_db' identifica o banco que será usado pelo aplicativo.
// Em plataformas nativas, como Linux e Android, o Drift/Drift Flutter usa
// esse nome para trabalhar com o arquivo SQLite do aplicativo.
//
// schemaVersion representa a versão da estrutura do nosso banco.
// Neste primeiro momento estamos na versão 1.
//
// No futuro, se modificarmos a estrutura da tabela e precisarmos fazer uma
// migração, aumentamos essa versão para 2, 3 e assim por diante, e usamos o
// stepByStep gerado pelo make-migrations.
//
// IMPORTANTE!!!
// o arquivo banco_dados.g.dart não deve ser editado manualmente.
// Se alterarmos este arquivo banco_dados.dart, executamos novamente:
//
// dart run build_runner build
//
// e o Drift gera/atualiza o arquivo banco_dados.g.dart automaticamente.
