import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/book.dart';

class Requests {
  Future<List<Book>> getAllBooks({int limit = 100, int startId = 1}) async {
    var url = 'http://127.0.0.1:8888/book?limit=$limit&startId=$startId';
    final response = await Dio().get(url,
        options: Options(
          headers: {"Authorization": "Basic dGVzdDp0ZXN0"},
        ));
    print(response.data);
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
}
