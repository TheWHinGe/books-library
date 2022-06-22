import 'dart:async';

import 'package:book_home_library_server/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class CreateDB {
  Database? _database;

  Future<Database> get database async =>
      _database != null ? _database! : await createTables();

  Future<Database> createTables() async {
    final db = await DataBase().initDB();

    await db.execute(
      "CREATE TABLE books ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT NOT NULL,"
      "genres INTEGER,"
      "status TEXT,"
      "FOREIGN KEY (genres) REFERENCES genres(id)"
      ")",
    );

    await db.execute(
      "CREATE TABLE genres ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT NOT NULL"
      ")",
    );
    await db.execute(
      "CREATE TABLE users ("
      "id INTEGER PRIMARY KEY,"
      "username TEXT NOT NULL,"
      "password TEXT NOT NULL,"
      "isAdmin INTEGER NOT NULL"
      ")",
    );

    return db;
  }
}
