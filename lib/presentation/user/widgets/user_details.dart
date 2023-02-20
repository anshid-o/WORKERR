import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';

class UserDetails extends StatelessWidget {
  ImageProvider img;
  String name;
  String page;

  int index;

  UserDetails(
      {super.key,
      this.page = 'chat',
      required this.name,
      required this.index,
      required this.img});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kc30,
      appBar: AppBar(
        backgroundColor: kc30,
        title: Text(name),
      ),
      body: Center(
        child: Hero(
          tag: 'image_$page$index',
          child: CircleAvatar(
            radius: size.width * .5,
            backgroundColor: kc30,
            backgroundImage: img,
          ),
        ),
      ),
    );
  }
}
