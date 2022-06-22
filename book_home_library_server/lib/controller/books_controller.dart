import 'dart:io';

import 'package:book_home_library_server/database.dart';
import 'package:book_home_library_server/errors_messages.dart';
import 'package:book_home_library_server/models/models.dart';
import 'package:conduit/conduit.dart';
// ignore: implementation_imports
import 'package:sqflite_common_ffi/src/sqflite_ffi_exception.dart'
    show SqfliteFfiException;

class BooksController extends ResourceController {
  @Operation.get()
  Future<Response> showAllBooks(
      {@Bind.query('startId') int startId = 1,
      @Bind.query('limit') int limit = 100}) async {
    final List<Book>? books = await DataBase().fetchAllBooks();
    if (books == null) {
      return ErrorsMessages.notFound('Not found books\n');
    }
    final List<Map<String, dynamic>> response =
        List.from(books.map((books) => books.toJson()));
    response.retainWhere((book) => book['id'] >= startId as bool);
    if (response.isEmpty) {
      return ErrorsMessages.notFound('Not found this books\n');
    }
    if (limit < response.length)
      response.length = response.length - (response.length - limit);
    return Response.ok(response)..contentType = ContentType.json;
  }

  @Operation.get('id')
  Future<Response> showBookById(@Bind.path('id') int id) async {
    final Book? book = await DataBase().fetchBook(id);
    if (book == null) {
      return ErrorsMessages.notFound('Not found id\n');
    }
    return Response.ok([book.toJson()])..contentType = ContentType.json;
  }

  @Operation.post()
  Future<Response> createBook(
      @Bind.body() Map<String, dynamic> bookJson) async {
    try {
      await DataBase().insertBook(Book.fromJson(bookJson));
    } on SqfliteFfiException catch (e) {
      if (e.getResultCode() == 1555)
        return Response.conflict(body: 'Conflict: UNIQUE constraint failed\n')
          ..contentType = ContentType.text;
    }
    return Response.ok('Successfully create\n')..contentType = ContentType.text;
  }

  @Operation.put()
  Future<Response> upgradingBook(
      @Bind.body() Map<String, dynamic> bookJson) async {
    final Book book = Book.fromJson(bookJson);
    final bool available = await DataBase().checkAvailabilityBook(book.id);
    if (available) {
      await DataBase().updateBook(Book.fromJson(bookJson));
    } else {
      return ErrorsMessages.notFound('Not found this book\n');
    }
    return Response.ok('Successfully update\n')..contentType = ContentType.text;
  }
}
