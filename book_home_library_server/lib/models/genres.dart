class Genres {
  Genres({
    required this.id,
    required this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  int id;
  String name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return '{id: $id, name: $name}';
  }
}
