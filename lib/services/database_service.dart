import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/registro.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    final caminhoBanco = await getDatabasesPath();

    final caminho = join(
      caminhoBanco,
      'app_offline.db',
    );

    _database = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE registros (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            texto TEXT NOT NULL,
            numero REAL NOT NULL,
            data TEXT,
            codigo TEXT NOT NULL
          )
          ''',
        );
      },
    );

    return _database!;
  }

  static Future<void> inserirRegistro(Registro registro) async {
    final db = await database;

    await db.insert(
      'registros',
      registro.toMap(),
    );
  }

  static Future<List<Registro>> listarRegistros() async {
    final db = await database;

    final resultado = await db.query(
      'registros',
      orderBy: 'id DESC',
    );

    return resultado
        .map((item) => Registro.fromMap(item))
        .toList();
  }
}