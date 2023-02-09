// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class ScreenFeedback extends StatefulWidget {
  ScreenFeedback({Key? key}) : super(key: key);

  @override
  State<ScreenFeedback> createState() => _ScreenFeedbackState();
}

class _ScreenFeedbackState extends State<ScreenFeedback> {
  TextEditingController wdet = TextEditingController();
  final storeUser = FirebaseFirestore.instance;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kc30,
          title: const Text('Feedback'),
          actions: [
            TextButton(
              onPressed: () {
                if (selected != 0) {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // print('user not null');
                      final now = DateTime.now();
                      String formatter = DateFormat('yMd').format(now);
                      storeUser.collection("Feedback").doc().set({
                        'uid': user.uid,
                        'state': selected,
                        'date': formatter,
                        'feedback': wdet.text
                      });

                      Navigator.pop(context);
                      showDone(context, 'Feedback posted successfully',
                          Icons.done, Colors.green);
                    }
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: kc30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            title: const Text(
                              'Error',
                              style: TextStyle(color: kc60),
                            ),
                            content: Text(e.toString(),
                                style: const TextStyle(color: kc60)),
                          );
                        });
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: kc30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          title: const Text(
                            'Error',
                            style: TextStyle(color: kc60),
                          ),
                          content: const Text(
                            'Please select one',
                            style: TextStyle(color: kc60),
                          ),
                        );
                      });
                }
                // Navigator.pop(context);
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: kc60, fontSize: 20),
              ),
            )
          ],
        ),
        backgroundColor: kc30,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EmojiFeedback(
              //   customLabels: const ['Strange', 'Bad', 'Ugly', 'Damaged', 'Love'],
              //   onChanged: (value) {
              //     print(value);
              //   },
              // )
              kheight,
              const Text(
                'What do you think of our App?',
                style: TextStyle(color: kc60, fontSize: 20),
              ),
              kheight,
              Divider(
                indent: size.width * .05,
                endIndent: size.width * .05,
              ),
              Container(
                decoration: BoxDecoration(
                    color: kc602, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selected == 1) {
                                setState(() {
                                  selected = 0;
                                });
                              } else {
                                setState(() {
                                  selected = 1;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: selected == 1
                                    ? size.width * .115
                                    : size.width * .08,
                                backgroundImage: const AssetImage(
                                    'assets/emoji/verybad.jpg')),
                          ),
                          Text(
                            'Very bad',
                            style: TextStyle(
                                color: selected == 1
                                    ? const Color.fromARGB(255, 158, 13, 3)
                                    : Colors.grey,
                                fontWeight: selected == 1
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: selected == 1 ? 18 : 15),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selected == 2) {
                                setState(() {
                                  selected = 0;
                                });
                              } else {
                                setState(() {
                                  selected = 2;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: selected == 2
                                    ? size.width * .115
                                    : size.width * .08,
                                backgroundImage:
                                    const AssetImage('assets/emoji/poor.jpg')),
                          ),
                          Text(
                            'Poor',
                            style: TextStyle(
                                color: selected == 2
                                    ? const Color.fromARGB(255, 255, 76, 63)
                                    : Colors.grey,
                                fontWeight: selected == 2
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: selected == 2 ? 18 : 15),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selected == 3) {
                                setState(() {
                                  selected = 0;
                                });
                              } else {
                                setState(() {
                                  selected = 3;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: selected == 3
                                    ? size.width * .115
                                    : size.width * .08,
                                backgroundImage: const AssetImage(
                                    'assets/emoji/medium.jpg')),
                          ),
                          Text(
                            'Medium',
                            style: TextStyle(
                                color: selected == 3
                                    ? const Color.fromARGB(255, 218, 165, 22)
                                    : Colors.grey,
                                fontWeight: selected == 3
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: selected == 3 ? 18 : 15),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selected == 4) {
                                setState(() {
                                  selected = 0;
                                });
                              } else {
                                setState(() {
                                  selected = 4;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: selected == 4
                                    ? size.width * .115
                                    : size.width * .08,
                                backgroundImage:
                                    const AssetImage('assets/emoji/good.jpg')),
                          ),
                          Text(
                            'Good',
                            style: TextStyle(
                                color: selected == 4
                                    ? const Color.fromARGB(255, 100, 185, 97)
                                    : Colors.grey,
                                fontWeight: selected == 4
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: selected == 4 ? 18 : 15),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selected == 5) {
                                setState(() {
                                  selected = 0;
                                });
                              } else {
                                setState(() {
                                  selected = 5;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: selected == 5
                                    ? size.width * .115
                                    : size.width * .08,
                                backgroundImage: const AssetImage(
                                    'assets/emoji/excellent.jpg')),
                          ),
                          Text(
                            'Excellent',
                            style: TextStyle(
                                color: selected == 5
                                    ? const Color.fromARGB(255, 9, 87, 3)
                                    : Colors.grey,
                                fontWeight: selected == 5
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: selected == 5 ? 18 : 15),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              kheight30,
              const Text(
                'What would you like to share with us?',
                style: TextStyle(color: kc60, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  indent: size.width * .05,
                  endIndent: size.width * .05,
                ),
              ),
              TextFormField(
                style: const TextStyle(color: kc602, fontSize: 20),
                controller: wdet,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kc10.withOpacity(.1),
                  hintText: 'Describe your experience (optional)',
                  label: const Text(
                    'Your thoughts',
                    style: TextStyle(color: kc60),
                    textAlign: TextAlign.start,
                  ),

                  // prefixIcon: const Icon(CupertinoIcons.info),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kc10, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(153, 148, 146, 146)),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kc10, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: const UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
