import 'package:books_web_client/models/book.dart';
import 'package:books_web_client/models/genres.dart';
import 'package:books_web_client/models/status.dart';
import 'package:books_web_client/requests.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key, required this.bookFunction}) : super(key: key);

  final Future<List<Book>> bookFunction;
  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: super.widget.bookFunction,
        builder: (context, AsyncSnapshot<List<Book>> bookSnap) {
          if (!bookSnap.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: bookSnap.data!.length,
              itemBuilder: (context, index) {
                Book book = bookSnap.data![index];
                return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                children: [
                                  const Text(
                                    'Имя',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(book.name),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  const Text(
                                    'Жанр',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(book.genres?.name ?? 'unknow'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  const Text(
                                    'Статус',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(book.status.toString()),
                                ],
                              ),
                            ),
                          ],
                        )));
              },
            );
          }
        },
      ),
    );
  }
}
