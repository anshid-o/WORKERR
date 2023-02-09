import 'package:flutter/material.dart';

class MessageRecieved extends StatelessWidget {
  String message;
  String time;

  IconData icon;
  MessageRecieved(
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
        tileColor: Color.fromARGB(255, 239, 206, 255),
        leading: Icon(icon),
        title: Text(message),
        subtitle: Text(time),
        trailing: CircleAvatar(
            radius: 15, child: Icon(Icons.keyboard_double_arrow_left)),
      ),
    );
  }
}
