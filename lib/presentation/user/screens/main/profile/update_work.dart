// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class UpdateWork extends StatefulWidget {
  String name;
  UpdateWork({Key? key, required this.name}) : super(key: key);

  @override
  State<UpdateWork> createState() => _UpdateWorkState();
}

class _UpdateWorkState extends State<UpdateWork> {
  final auth = FirebaseAuth.instance;

  //   FirebaseFirestore firebase = FirebaseFirestore.instance;
  // final user = FirebaseAuth.instance.currentUser!;

  final storeUser = FirebaseFirestore.instance;

  final kexp = TextEditingController();
  final kdet = TextEditingController();
  int currentStep = 0;
  List<String> works = [
    'Plumbing',
    'Painting',
    'Gypsum works',
    'Fabrication works',
    'Electric repairs',
    'Mechanic',
    'Driver'
  ];
  String selectedItem = 'Plumbing';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: kc30, title: const Text('Update Work')),
        body: Center(
          child: Stepper(
            steps: [
              Step(
                isActive: currentStep == 0,
                title: const Text(
                  'Specify work title',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                content: Row(
                  children: [
                    Container(
                      width: size.width * .6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 229, 229, 229)),
                      child: DropdownButtonFormField<String>(
                        // dropdownColor: ,
                        // iconSize: 20,
                        elevation: 8,
                        // autofocus: true,
                        decoration: InputDecoration(
                            fillColor: kgold,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(width: 2, color: kc10))),
                        value: selectedItem,
                        items: works
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedItem = item!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Step(
                isActive: currentStep == 1,
                title: const Text(
                  'Specify experience',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                content: MyTextForm(
                    textColor: Colors.black,
                    kt: kexp,
                    name: 'Experience',
                    icon: Icons.group_work_outlined),
              ),
              Step(
                isActive: currentStep == 2,
                title: const Text(
                  'Specify More details',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                content: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: kdet,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kc60.withOpacity(.2),
                    label: const Text(
                      'Details',
                      style: TextStyle(color: kc10),
                      textAlign: TextAlign.start,
                    ),
                    prefixIcon: const Icon(
                      Icons.details_rounded,
                      color: kc10,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: kc10, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 54, 9, 62)),
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
              ),
            ],
            currentStep: currentStep,
            onStepTapped: (value) {
              setState(() {
                currentStep = value;
              });
            },
            onStepContinue: () {
              // if (currentStep == 0) {
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         backgroundColor: kc30,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         title: const Text(
              //           'Error',
              //           style: TextStyle(color: kc60),
              //         ),
              //         content: const Text('Please enter yor work !!!',
              //             style: TextStyle(color: kc60)),
              //       );
              //     });
              // } else
              if (currentStep == 1 && kexp.text.isEmpty) {
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
                        content: const Text('Please specify yor experience !!!',
                            style: TextStyle(color: kc60)),
                      );
                    });
              } else if (currentStep == 2 && kdet.text.isEmpty) {
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
                        content: const Text('Please enter yor work details !!!',
                            style: TextStyle(color: kc60)),
                      );
                    });
              } else if (currentStep != 2) {
                setState(() {
                  currentStep += 1;
                });
              } else {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final now = DateTime.now();
                    String formatter = DateFormat('yMd').format(now);
                    // print('user not null');

                    // .where("field", "==", certainValue)

                    storeUser.collection("Workers").doc(user.uid).set({
                      'uid': user.uid,
                      'job': selectedItem,
                      'details': kdet.text,
                      'name': widget.name,
                      'count': 0,
                      'rating': 0,
                      'experience': kexp.text,
                      'status': 'Requested',
                      'date': formatter,
                      'time': now
                    });
                    showDone(context, 'Work Updated', Icons.done, Colors.green);
                    Navigator.pop(context);
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
              }
            },
            onStepCancel: () {
              if (currentStep != 0) {
                setState(() {
                  currentStep -= 1;
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
