// To parse this JSON data, do
//
//     final wworks = wworksFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Wworks? wworksFromJson(String str) => Wworks.fromJson(json.decode(str));

String wworksToJson(Wworks? data) => json.encode(data!.toJson());

class Wworks {
  Wworks({
    this.details,
    this.status,
    this.uid,
    this.work,
    this.date,
  });

  String? details;
  String? status;
  String? uid;
  String? work;
  String? date;

  factory Wworks.fromJson(Map<String, dynamic> json) => Wworks(
        details: json["details"],
        status: json["status"],
        uid: json["uid"],
        work: json["work"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "status": status,
        "uid": uid,
        "work": work,
        "date": date,
      };

  // Factory Wworks.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
  //   final data=document.data;
  //   return Wworks(
  //     uid: data['uid'],
  //     work: work,
  //     details: details,
  //     date: date,
  //     status: status,

  //   );
  // }
}
