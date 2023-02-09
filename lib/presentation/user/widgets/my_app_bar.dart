import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';

class MyAppBar extends StatelessWidget {
  String name;
  String url;
  LinearGradient? wt;
  Color? tc;
  double ht;
  bool top;

  MyAppBar(
      {Key? key,
      required this.name,
      this.wt = kblackgd2,
      this.ht = 50,
      this.top = false,
      this.url = 'assets/workerr_long.jpg',
      this.tc = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          kwidth,
          Text(
            name,
            style: TextStyle(
              color: tc,
              fontSize: 20,
              // decoration: TextDecoration.underline,
              // decorationStyle: TextDecorationStyle.solid,
              // decorationThickness: 2.5,
              // decorationColor: Colors.,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (top)
            IconButton(
              tooltip: 'Top Workers',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTabbedAppBar(),
                  ),
                );
              },
              icon: const Icon(
                // CupertinoIcons.citty,
                Icons.people_outline,
                color: Color.fromARGB(255, 255, 200, 200),
              ),
            ),
        ],
      ),
    );
  }
}
