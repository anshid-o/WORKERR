import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime date;

  final bool isSentByMe;

  Message({required this.text, required this.date, required this.isSentByMe});
}
