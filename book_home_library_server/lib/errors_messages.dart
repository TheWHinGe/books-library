import 'package:book_home_library_server/book_home_library_server.dart';

class ErrorsMessages {
  static Response notFound(String message) {
    return Response.notFound(body: message)..contentType = ContentType.text;
  }
}
