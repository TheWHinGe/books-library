import 'dart:async';
import 'dart:io';

import 'package:book_home_library_server/database.dart';
import 'package:book_home_library_server/models/models.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AddTestKeys {
  Database? _database;

  Future<Database> get database async =>
      _database != null ? _database! : await DataBase().initDB();

  Future<Database> initDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    const fileName = 'books.db';
    final currentDir = Directory.current.path;
    final file = File(p.join(currentDir, fileName));
    final Database db = await databaseFactory.openDatabase(file.path);
    return db;
  }

  final List<Book> books = [
    Book(
      id: 1,
      name: 'Garry Potter',
      genres: Genres(id: 1, name: 'fantasy'),
      status: Status.unread,
    ),
    Book(
      id: 2,
      name: 'Peter pan',
      genres: Genres(
        id: 2,
        name: 'musical',
      ),
      status: Status.read,
    ),
    Book(
      id: 3,
      name: 'The Curse of the Baskervilles',
      status: Status.unread,
    ),
    Book(
      id: 4,
      name: 'War and Peace',
      status: Status.read,
    ),
  ];

  void addTestInfo() {
    DataBase().createGenre(Genres(id: 1, name: 'fantasy'));
    DataBase().createGenre(Genres(id: 2, name: 'musical'));
    DataBase().createUser(Users(
      id: 1,
      password: 'test',
      username: 'test',
      isAdmin: 1,
    ));
    books.forEach(
      (book) {
        DataBase().insertBook(book);
      },
    );
  }
}
