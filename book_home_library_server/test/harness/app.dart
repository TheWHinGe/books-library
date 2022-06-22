import 'package:book_home_library_server/book_home_library_server.dart';
import 'package:conduit_test/conduit_test.dart';

export 'package:book_home_library_server/book_home_library_server.dart';
export 'package:conduit_test/conduit_test.dart';
export 'package:test/test.dart';

/// A testing harness for book_home_library_server.
///
/// A harness for testing an conduit application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<BookHomeLibraryServerChannel> {
  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
