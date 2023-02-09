// To parse this JSON data, do
//
//     final wadmins = wadminsFromJson(jsonString);

import 'dart:convert';

Wadmins? wadminsFromJson(String str) => Wadmins.fromJson(json.decode(str));

String wadminsToJson(Wadmins? data) => json.encode(data!.toJson());

class Wadmins {
  Wadmins({
    required this.email,
    required this.name,
    required this.password,
    required this.uid,
  });

  String email;
  String name;
  String password;
  String uid;

  factory Wadmins.fromJson(Map<String, dynamic> json) => Wadmins(
        email: json["email"],
        name: json["name"],
        password: json["password"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "password": password,
        "uid": uid,
      };
}
