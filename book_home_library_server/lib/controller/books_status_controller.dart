import 'dart:io';

import 'package:book_home_library_server/database.dart';
import 'package:book_home_library_server/errors_messages.dart';
import 'package:book_home_library_server/models/models.dart';
import 'package:conduit/conduit.dart';

class BooksStatusController extends ResourceController {
  @Operation.get()
  Future<Response> getAllBooksStatus(
      @Bind.query('status') String status) async {
    final List<Book>? books = await DataBase().fetchAllBooks();
    if (books == null) {
      return ErrorsMessages.notFound('Not found books\n');
    }
    final List<Map<String, dynamic>> response =
        List.from(books.map((books) => books.toJson()));
    response.retainWhere((book) => book['status'] == status);
    if (response.isEmpty) {
      return ErrorsMessages.notFound('Not found $status books\n');
    }
    return Response.ok(response)..contentType = ContentType.json;
  }
}
