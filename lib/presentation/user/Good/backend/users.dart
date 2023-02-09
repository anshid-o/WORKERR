// To parse this JSON data, do
//
//     final wusers = wusersFromJson(jsonString);

import 'dart:convert';

Wusers? wusersFromJson(String str) => Wusers.fromJson(json.decode(str));

String wusersToJson(Wusers? data) => json.encode(data!.toJson());

class Wusers {
  Wusers({
    required this.email,
    required this.name,
    required this.status,
    required this.password,
    required this.phone,
    required this.pin,
    required this.uid,
  });

  String email;
  String status;
  String name;
  String password;
  String phone;
  String pin;
  String uid;

  factory Wusers.fromJson(Map<String, dynamic> json) => Wusers(
        email: json["email"],
        status: json["status"],
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        pin: json["pin"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "status": status,
        "name": name,
        "password": password,
        "phone": phone,
        "pin": pin,
        "uid": uid,
      };
}
