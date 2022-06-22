import 'dart:async';
import 'dart:io';

import 'package:book_home_library_server/models/book.dart';
import 'package:book_home_library_server/models/genres.dart';
import 'package:book_home_library_server/models/models.dart';
import 'package:book_home_library_server/utils/extension.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBase {
  Database? _database;

  Future<Database> get database async =>
      _database != null ? _database! : await initDB();

  Future<Database> initDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    const fileName = 'books.db';
    final currentDir = Directory.current.path;
    final file = File(p.join(currentDir, fileName));
    final Database db = await databaseFactory.openDatabase(file.path);
    return db;
  }

  Future<void> insertBook(Book book) async {
    final Database dbClient = await database;
    await dbClient.insert(
      'books',
      book.toJson(isBD: true),
    );
  }

  Future<void> createGenre(Genres genres) async {
    final Database dbClient = await database;
    await dbClient.insert(
      'genres',
      genres.toJson(),
    );
  }

  Future<void> createUser(Users user) async {
    final Database dbClient = await database;
    await dbClient.insert(
      'users',
      user.toJson(),
    );
  }

  Future<Book?> fetchBook(int id) async {
    final Database dbClient = await database;
    final res = await dbClient.rawQuery(
        'SELECT books.id, books.name, books.status,books.genres, genres.id as idStatus, genres.name as genresName FROM books LEFT OUTER JOIN genres on books.genres = genres.id WHERE books.id = $id');
    return res.isNotEmpty ? Book.fromJson(res[0], isBD: true) : null;
  }

  Future<bool> checkAvailabilityBook(int id) async {
    final Database dbClient = await database;
    final res = await dbClient.rawQuery(
        'SELECT EXISTS(SELECT id FROM books WHERE id = $id) as available');
    return (res[0]['available'] as int).toBool();
  }

  Future<void> updateBook(Book book) async {
    final Database dbClient = await database;
    await dbClient.update(
      'books',
      book.toJson(isBD: true),
      where: "id = ?",
      whereArgs: [book.id],
    );
  }

  Future<List<Book>?> fetchAllBooks() async {
    final Database dbClient = await database;
    final res = await dbClient.rawQuery(
        'SELECT books.id, books.name, books.status,books.genres, genres.id as idStatus, genres.name as genresName FROM books LEFT OUTER JOIN genres on books.genres = genres.id');
    final List<Book>? list = res.isNotEmpty
        ? res.map((book) => Book.fromJson(book, isBD: true)).toList()
        : null;
    return list;
  }

  Future<List<Users>?> fetchAllUsers() async {
    final Database dbClient = await database;
    final res = await dbClient.query('users');
    final List<Users>? list =
        res.isNotEmpty ? res.map(Users.fromJson).toList() : null;
    return list;
  }
}
