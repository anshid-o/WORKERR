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
  int _selectedEmoji = 0;
  TextEditingController wdet = TextEditingController();
  final storeUser = FirebaseFirestore.instance;

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
                if (_selectedEmoji != 0) {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // print('user not null');
                      final now = DateTime.now();
                      String formatter = DateFormat('yMd').format(now);
                      storeUser.collection("Feedback").doc().set({
                        'uid': user.uid,
                        'state': _selectedEmoji,
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
              // const Text(
              //   'What do you think of our App?',
              //   style: TextStyle(color: kc60, fontSize: 20),
              // ),

              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("How was your experience?",
                          style: TextStyle(fontSize: 24.0)),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = 1;
                                });
                              },
                              child: Container(
                                height: _selectedEmoji == 1 ? 75.0 : 60,
                                width: _selectedEmoji == 1 ? 75.0 : 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _selectedEmoji == 1
                                            ? Colors.blue
                                            : Colors.grey,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Center(
                                  child: Text(
                                    "😡",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = 2;
                                });
                              },
                              child: Container(
                                height: _selectedEmoji == 2 ? 75.0 : 60,
                                width: _selectedEmoji == 2 ? 75.0 : 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _selectedEmoji == 2
                                            ? Colors.blue
                                            : Colors.grey,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Center(
                                  child: Text(
                                    "😞",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = 3;
                                });
                              },
                              child: Container(
                                height: _selectedEmoji == 3 ? 75.0 : 60,
                                width: _selectedEmoji == 3 ? 75.0 : 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _selectedEmoji == 3
                                            ? Colors.blue
                                            : Colors.grey,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Center(
                                  child: Text(
                                    "😐",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = 4;
                                });
                              },
                              child: Container(
                                height: _selectedEmoji == 4 ? 75.0 : 60,
                                width: _selectedEmoji == 4 ? 75.0 : 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _selectedEmoji == 4
                                            ? Colors.blue
                                            : Colors.grey,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Center(
                                  child: Text(
                                    "🙂",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = 5;
                                });
                              },
                              child: Container(
                                height: _selectedEmoji == 5 ? 75.0 : 60,
                                width: _selectedEmoji == 5 ? 75.0 : 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _selectedEmoji == 5
                                            ? Colors.blue
                                            : Colors.grey,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Center(
                                  child: Text(
                                    "😄",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ]),
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
