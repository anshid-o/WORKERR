import 'package:flutter/material.dart';

class MessageSent extends StatelessWidget {
  String message;
  String time;

  IconData icon;
  MessageSent(
      {Key? key,
      required this.message,
      this.icon = Icons.done_all,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // selected: true,

        // style: ListTileStyle.list,
        tileColor: Color.fromARGB(255, 217, 230, 252),
        leading: CircleAvatar(radius: 15, child: Icon(Icons.double_arrow)),
        title: Text(message),
        subtitle: Text(time),
        trailing: Icon(icon),
      ),
    );
  }
}
