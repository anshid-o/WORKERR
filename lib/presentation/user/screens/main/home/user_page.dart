import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class UserPage extends StatelessWidget {
  ImageProvider img;
  String name;
  UserPage({super.key, required this.name, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(name),
      ),
      body: Center(child: Hero(tag: 'user_image', child: Image(image: img))),
    );
  }
}
