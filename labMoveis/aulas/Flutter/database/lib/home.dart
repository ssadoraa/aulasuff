import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recoverDatabase() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    
    String path = p.join(appDocumentsDir.path, "databases", "banco.db");
    print("Database path: $path");
    Database db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          String sql = """
            CREATE TABLE usuario(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome VARCHAR(1000),
              idade INTEGER
            );
          """;

          await db.execute(sql);
        }
      )
    );

    return db;
  }

  _save() async {
    Database db = await _recoverDatabase();

    Map<String, dynamic> userData = {
      "nome": "Maria Silva",
      "idade": 30
    };

    int id = await db.insert("usuario", userData);
    print("User id: $id");
  }

  _list() async {
    Database db = await _recoverDatabase();

    String sql = "SELECT * FROM usuarios";

    List usuarios = await db.rawQuery(sql);
    print(usuarios);
  }

  @override
  Widget build(BuildContext context) {

    // _save();
    _list();

    return Scaffold(
      appBar: AppBar(
        title: Text("Database Exemplo"),
      ),
      body: Text("Exemplos com Database"),
    );
  }
}