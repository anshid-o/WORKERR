import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class WaitingCard extends StatelessWidget {
  const WaitingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        width: 380,
        height: 172,
        // color: Colors.blue,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: kbluegd,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        'Mechanic',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kred,
                            letterSpacing: 3),
                      ),
                      // Spacer(),

                      kwidth20,
                      Text(
                        '14/07/2022',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ksize(y: 93.0),
                      const Text(
                        '- 2 years',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 75,
                    child: const Center(
                      child: Text(
                        'I was worked as an assistant mechanic at zen Shop for past 2 years. Conact number to zen shop : 9472647283',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 245, 251),
                            fontSize: 14,
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        kwidth20,
                        Text(
                          'From : Koolimadu',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.domain_verification_rounded,
                    size: 50,
                    color: kgreen2,
                    shadows: kshadow,
                  ),
                  Text(
                    'Status',
                    style: TextStyle(
                      shadows: kshadow,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: kgreen2,
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
