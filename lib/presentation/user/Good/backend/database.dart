import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  // final CollectionReference wUsers = FirebaseFireStore.instance.collection();
  final CollectionReference wUsers =
      FirebaseFirestore.instance.collection('Users');

  // final CollectionReference wUsers=FireStore.instance.collection();

  Future updateUsers(
      String name,
      String phone,
      String gender,
      String place,
      String pin,
      String district,
      String email,
      String password,
      String url,
      String status) async {
    return await wUsers.doc(uid).set({
      'name': name,
      'phone': phone,
      'gender': gender,
      'place': place,
      'pin': pin,
      'district': district,
      'email': email,
      'password': password,
      'url': url,
      'status': status
    });
  }

  Stream<QuerySnapshot> get users {
    return wUsers.snapshots();
  }
}
