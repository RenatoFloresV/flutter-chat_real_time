import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String email;
  String uid;
  bool isOnline = false;

  User({
    required this.name,
    required this.email,
    required this.uid,
    this.isOnline = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        uid: json["uid"] ?? '',
        isOnline: json["online"] ?? false,
      );

  factory User.fromMap(json) => User(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        uid: json['uid'] ?? '',
        isOnline: json['online'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
      };
}
