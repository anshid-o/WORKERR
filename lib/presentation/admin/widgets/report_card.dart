import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
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
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: kblue2,
                    child: Icon(
                      Icons.person,
                      shadows: kshadow,
                      color: Color.fromARGB(255, 1, 51, 8),
                      size: 50,
                    ),
                  ),
                  Text(
                    'Mishal Jaleel',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kblue,
                        letterSpacing: 2),
                  ),
                  // Spacer(),
                  kwidth30,

                  kwidth30,
                  Text(
                    '10/05/2021',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 70,
                    width: 300,
                    child: const Text(
                      'I am a plumber , yesterday i got a request from a user named althaf and i goto work in that place by contacting him. but those detals are wrong. Please take actions to those kind users.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: kgreen,
                    child: Text(
                      'UT',
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
