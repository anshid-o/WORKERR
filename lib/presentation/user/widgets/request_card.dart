import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 285,
            height: 172,
            // color: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: kbluegd,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.color_lens,
                        shadows: kshadow,
                        color: Color.fromARGB(255, 1, 51, 8),
                      ),
                      Text(
                        'Painting',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kred,
                            letterSpacing: 3),
                      ),
                      // Spacer(),
                      kwidth30,
                      kwidth20,
                      Text(
                        '10/05/2021',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 90,
                    child: const Center(
                      child: Text(
                        'I have a painting job to be done in my new shop, it has almost 2000 square feet wall. i want to be done this work before 15th. If you intrested to do the work , Please contact.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 245, 251),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 290,
                    decoration: BoxDecoration(
                        gradient: kgreengd,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: const [
                        kwidth,
                        Text(
                          'By : Anshid O',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        kwidth30,
                        Text(
                          'From : Areakode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '  Message',
                style: TextStyle(
                  shadows: kshadow,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: kgreen2,
                ),
              ),
              IconButton(
                tooltip: 'Send Message to Anshid O',
                // alignment: Alignment.topRight,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ChatScreenChild(
                        name: 'Anshid O',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.message,
                  size: 45,
                  color: kgreen2,
                  shadows: kshadow,
                ),
              ),
              kheight,
            ],
          )
        ],
      ),
    );
  }
}
