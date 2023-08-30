import 'dart:async';

import 'package:path/path.dart';
import 'package:aa2_mobile/persistence/consulta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

const tableName = 'consultas';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  Future<Database> get database async => _database ?? await _initDB();

  Future<Database> _initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'consultas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id TEXT PRIMARY KEY,'
          'profissional TEXT,'
          'specialty TEXT,'
          'date TEXT,'
          'time TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Consulta>> getAllConsultas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    // Log response
    if (kDebugMode) {
      print(List.generate(maps.length, (i) => Consulta.fromMap(maps[i])));
    }
    return List.generate(maps.length, (i) => Consulta.fromMap(maps[i]));
  }

  Future<void> insertNewConsulta(Consulta consulta) async {
    final db = await database;
    if (kDebugMode) {
      print("${consulta.profissional} inserido(a) com sucesso!");
    }
    await db.insert(tableName, consulta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateConsulta(Consulta consulta) async {
    final db = await database;
    await db.update(tableName, consulta.toMap(),
        where: 'id = ?', whereArgs: [consulta.id]);
  }

  Future<void> deleteConsulta(Consulta consulta) async {
    final db = await database;
    if (kDebugMode) {
      print("Deletando consulta de ${consulta.profissional}");
    }
    await db.delete(tableName, where: 'id = ?', whereArgs: [consulta.id]);
  }
}
