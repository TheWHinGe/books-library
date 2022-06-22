import 'package:books_web_client/models/book.dart';
import 'package:books_web_client/models/genres.dart';
import 'package:books_web_client/models/status.dart';
import 'package:books_web_client/pages/books_page.dart';
import 'package:books_web_client/requests.dart';
import 'package:dio/dio.dart';
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
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MyHomePage(),
      //   '/second': (context) => const BooksPage(),
      // },
      home: const Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
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
                      controller: myController,
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
                      controller: myController,
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
                                bookFunction: Requests().getAllBooks())),
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
                      controller: myController,
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
                      if (myController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BooksPage(
                                  bookFunction: Requests()
                                      .showBookById(myController.text))),
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

  SizedBox drowWidget(String description, Function() function) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Получить список всех книг',
          ),
          ElevatedButton(
            onPressed: function,
            // Requests().getAllBooks,
            child: const Icon(Icons.book),
          ),
        ],
      ),
    );
  }
}
