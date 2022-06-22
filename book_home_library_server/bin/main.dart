import 'package:book_home_library_server/book_home_library_server.dart';
import 'package:book_home_library_server/initDB/addTestKeys.dart';
import 'package:book_home_library_server/initDB/createDB.dart';
import 'package:path/path.dart' as p;

Future main() async {
  final app = Application<BookHomeLibraryServerChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  const fileName = 'books.db';
  final currentDir = Directory.current.path;
  final file = File(p.join(currentDir, fileName));

  // ignore: avoid_slow_async_io
  final exisFile = await file.exists();

  if (!exisFile) {
    await CreateDB().createTables();
    print('Создана БД');
    AddTestKeys().addTestInfo();
    print('Добавлена информация');
  }

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
