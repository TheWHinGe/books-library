import 'package:books_web_client/api/requests.dart';
import 'package:books_web_client/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookCreatePage extends StatefulWidget {
  const BookCreatePage({Key? key}) : super(key: key);

  @override
  State<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends State<BookCreatePage> {
  static List<Genres> genresChoose = [
    Genres(id: 1, name: 'fantasy'),
    Genres(id: 2, name: 'musical')
  ];
  Status? _status;
  Genres? _genres;

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final genresController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    genresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              'ID',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 400,
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
            const Text(
              'NAME',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 400,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'НАЗВАНИЕ КНИГИ',
                ),
              ),
            ),
            const Text(
              'GENRES',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 400,
              child: DropdownButton<Genres>(
                value: _genres,
                items: genresChoose.map((Genres val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.name,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                hint: const Text(
                  'Выберите жанр',
                  textAlign: TextAlign.center,
                ),
                onChanged: (Genres? value) {
                  setState(() {
                    _genres = value!;
                  });
                },
              ),
            ),
            const Text(
              'STATUS',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 400,
              child: DropdownButton<Status>(
                value: _status,
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
                  'Выберите статус',
                  textAlign: TextAlign.center,
                ),
                onChanged: (Status? value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                var book = Book(
                  id: int.parse(idController.text),
                  name: nameController.text,
                  status: _status,
                  genres: _genres,
                );
                Requests().createBook(book);
                Navigator.pop(context);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
