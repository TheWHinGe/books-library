import 'package:books_web_client/models/book.dart';
import 'package:dio/dio.dart';

class Requests {
  Future<List<Book>> getAllBooks(
      {required String limit, required String startId}) async {
    if (limit.isEmpty) limit = '100';
    if (startId.isEmpty) startId = '1';

    var url = 'http://127.0.0.1:8888/book?limit=$limit&startId=$startId';
    final response = await Dio().get(url,
        options: Options(
          headers: {"Authorization": "Basic dGVzdDp0ZXN0"},
        ));
    return List<Map<String, dynamic>>.from(response.data)
        .map((book) => Book.fromJson(book))
        .toList();
  }

  Future<List<Book>> getAllBooksStatus(String status) async {
    var url = 'http://127.0.0.1:8888/book/findByStatus?status=$status';
    final response = await Dio().get(url,
        options: Options(
          headers: {"Authorization": "Basic dGVzdDp0ZXN0"},
        ));
    return List<Map<String, dynamic>>.from(response.data)
        .map((book) => Book.fromJson(book))
        .toList();
  }

  Future<List<Book>> showBookById(String id) async {
    var url = 'http://127.0.0.1:8888/book/$id';
    final response = await Dio().get(url,
        options: Options(
          headers: {"Authorization": "Basic dGVzdDp0ZXN0"},
        ));
    return List<Map<String, dynamic>>.from(response.data)
        .map((book) => Book.fromJson(book))
        .toList();
  }

  void createBook(Book book) async {
    var url = 'http://127.0.0.1:8888/book';
    await Dio().post(url,
        data: book.toJson(),
        options: Options(
          headers: {"Authorization": "Basic dGVzdDp0ZXN0"},
        ));
  }
}
