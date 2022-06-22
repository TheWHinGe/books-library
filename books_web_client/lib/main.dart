import 'package:books_web_client/models/status.dart';
import 'package:books_web_client/pages/book_create_page.dart';
import 'package:books_web_client/pages/books_page.dart';
import 'package:books_web_client/api/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book library',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MyHomePage(),
      //   '/second': (context) => const BooksPage(),
      // },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final limitController = TextEditingController();
  final startIdController = TextEditingController();
  final idController = TextEditingController();
  Status? status;

  @override
  void dispose() {
    limitController.dispose();
    startIdController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Получить список всех книг',
                  ),
                  SizedBox(
                    height: 35,
                    width: 55,
                    child: TextField(
                      controller: limitController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'limit',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 75,
                    child: TextField(
                      controller: startIdController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'startID',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BooksPage(
                                    bookFunction: Requests().getAllBooks(
                                  limit: limitController.text,
                                  startId: startIdController.text,
                                ))),
                      );
                    },
                    child: const Icon(Icons.book),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Получить книгу по id',
                  ),
                  SizedBox(
                    height: 35,
                    width: 55,
                    child: TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ID',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (idController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BooksPage(
                                  bookFunction: Requests()
                                      .showBookById(idController.text))),
                        );
                      }
                    },
                    child: const Icon(Icons.book),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Добавить книгу',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookCreatePage(),
                        ),
                      );
                    },
                    child: const Icon(Icons.book),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 450,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Посмотреть книгу по статусу',
                  ),
                  SizedBox(
                    //  height: 35,
                    width: 150,
                    child: DropdownButton<Status>(
                      value: status,
                      items: Status.values.map((Status val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val.name,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        'Введите статус',
                        textAlign: TextAlign.center,
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          status = value!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (status != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BooksPage(
                                  bookFunction: Requests()
                                      .getAllBooksStatus(status!.name))),
                        );
                      }
                    },
                    child: const Icon(Icons.book),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
