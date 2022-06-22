import 'package:books_web_client/models/models.dart';
import 'package:enum_object/enum_object.dart';

class Book {
  Book({
    required this.id,
    required this.name,
    this.genres,
    this.status,
  });

  factory Book.fromJson(Map<String, dynamic> json, {bool isBD = false}) {
    return Book(
      id: json['id'] as int,
      name: json['name'] as String,
      genres: json['genres'] == null
          ? null
          : Genres(
              id: json['genres']['id'] as int,
              name: json['genres']['name'] as String),
      status: json['status'] == null
          ? null
          : EnumObject<Status?>(Status.values)
              .enumFromString(json['status'] as String),
    );
  }
  int id;
  String name;
  Genres? genres;
  Status? status;

  Map<String, dynamic> toJson({bool isBD = false}) => {
        'id': id,
        'name': name,
        'genres': isBD ? genres?.id : genres,
        'status': status?.name,
      };
}
