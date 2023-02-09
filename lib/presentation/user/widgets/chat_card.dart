import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        width: 380,
        height: 150,
        // color: Colors.blue,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: kgreengd2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: kblue2,
                    child: Icon(
                      Icons.person,
                      shadows: kshadow,
                      color: Color.fromARGB(255, 1, 51, 8),
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ChatScreenChild(
                                    name: 'Mishal Jaleel',
                                  )));
                    },
                    child: const Text(
                      'Mishal Jaleel',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kblue,
                          letterSpacing: 2),
                    ),
                  ),
                  // Spacer(),
                  kwidth30,

                  kwidth,
                  const Text(
                    '10/05/2021',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Hello, I am intrested to do the plumbing work.\nCan you call me when you are free ?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: kgreen,
                    child: Text(
                      '+5',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
