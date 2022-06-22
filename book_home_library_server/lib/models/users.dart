class Users {
  Users({
    required this.id,
    required this.username,
    required this.password,
    required this.isAdmin,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as int,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'isAdmin': isAdmin,
      };

  int id;
  String username;
  String password;
  int isAdmin;
}
