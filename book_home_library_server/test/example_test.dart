import 'package:book_home_library_server/initDB/addTestKeys.dart';

import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /example returns 200 {'key': 'value'}", () async {
    expectResponse(await harness.agent?.get("/example"), 200,
        body: {"key": "value"});
  });
  test("GET /book/1 returns book id 1", () async {
    expectResponse(await harness.agent?.get("/book/3"), 200,
        body: partial({
          "id": greaterThan(0),
          "name": isNotNull,
          "genres": anything,
          "status": anything,
        }));
  });
}
