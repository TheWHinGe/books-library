import 'package:book_home_library_server/book_home_library_server.dart';
import 'package:book_home_library_server/controller/books_controller.dart';
import 'package:book_home_library_server/controller/books_status_controller.dart';
import 'package:book_home_library_server/models/models.dart';

class BookHomeLibraryServerChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route('/book/[:id([0-9]+)]')
        .link(() => Authorizer.basic(PasswordVerifier()))!
        .link(BooksController.new);
    router
        .route('/book/findByStatus')
        .link(() => Authorizer.basic(PasswordVerifier()))!
        .link(BooksStatusController.new);

    return router;
  }
}

class PasswordVerifier extends AuthValidator {
  @override
  FutureOr<Authorization>? validate<T>(
      AuthorizationParser<T> parser, T authorizationData,
      {List<AuthScope>? requiredScope}) {
    if (!isPasswordCorrect(authorizationData as AuthBasicCredentials)) {
      return null;
    }
    return Authorization(null, 1, this);
  }

  bool isPasswordCorrect(AuthBasicCredentials authorizationData) {
    final List<Users> _users = [
      Users(
        id: 1,
        password: 'test',
        username: 'test',
        isAdmin: 1,
      )
    ];
    return _users.every((user) =>
        (user.username == authorizationData.username) &&
        (user.password == authorizationData.password));
  }
}
