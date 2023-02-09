import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/view_responses.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class ScreenReport extends StatefulWidget {
  const ScreenReport({Key? key}) : super(key: key);

  @override
  State<ScreenReport> createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  TextEditingController ksub = TextEditingController();
  // List<String> reports = ['About User', 'About App'];
  // String selectedItem = 'About User';
  TextEditingController rdet = TextEditingController();
  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kc30,
        appBar: AppBar(
          // shadowColor: Colors.white,
          // bottomOpacity: 0,
          // foregroundColor: Colors.white,
          backgroundColor: kc30.withGreen(18),
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: kc60,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewResponses(),
                      ));
                },
                icon: const Icon(Icons.messenger_outline_sharp))
          ],
          title: Row(children: const [
            kwidth20,
            kwidth20,
            kwidth,
            Text(
              'Report an issue',
              style: TextStyle(
                color: kc60,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                height: 0,
              ),
              kheight20,
              const CircleAvatar(
                radius: 50,
                backgroundColor: kc602,
                child: Icon(
                  Icons.report_gmailerrorred_rounded,
                  shadows: kshadow2,
                  size: 70,
                ),
              ),
              kheight30,
              Container(
                width: 350,
                height: 430,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23), color: kc602),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text(
                        "Enter Details",
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          // fontStyle: FontStyle.italic,
                          // backgroundColor: kgold,
                          color: kc30,

                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          // decoration: TextDecoration.underline,
                          // decorationThickness: 1.3,
                          // decorationColor: kred,
                        ),
                      ),
                      kheight30,
                      MyTextForm(
                          textColor: Colors.black,
                          name: 'Enter subject',
                          icon: Icons.label_important,
                          kt: ksub)
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Type of Report : ',
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Container(
                      //       width: 190,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: kc602),
                      //       child: DropdownButtonFormField<String>(
                      //         // dropdownColor: ,
                      //         // iconSize: 20,
                      //         elevation: 8,
                      //         // autofocus: true,
                      //         decoration: InputDecoration(
                      //             fillColor: kgold,
                      //             enabledBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 borderSide: const BorderSide(
                      //                     width: 2, color: kc10))),
                      //         value: selectedItem,
                      //         items: reports
                      //             .map(
                      //               (item) => DropdownMenuItem<String>(
                      //                 value: item,
                      //                 child: Text(
                      //                   item,
                      //                   style: const TextStyle(
                      //                       fontSize: 15,
                      //                       color: Colors.black87,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             )
                      //             .toList(),
                      //         onChanged: (item) {
                      //           setState(() {
                      //             selectedItem = item!;
                      //           });
                      //         },
                      //       ),
                      //     )
                      //   ],
                      // ),
                      ,
                      kheight30,
                      TextFormField(
                        controller: rdet,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kc10.withOpacity(.1),
                          label: const Text(
                            'Details',
                            textAlign: TextAlign.start,
                          ),
                          prefixIcon: const Icon(Icons.report),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: kc10, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 54, 9, 62)),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: kc10, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          border: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      kheight30,
                      // MyTextForm(name: 'About (optional)', icon: Icons.person),
                      kheight20,
                      kheight20,
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (rdet.text.isNotEmpty) {
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  // print('user not null');
                                  final now = DateTime.now();
                                  String formatter =
                                      DateFormat('yMd').format(now);
                                  storeUser.collection("Reports").doc().set({
                                    'uid': user.uid,
                                    'subject': ksub.text,
                                    'date': formatter,
                                    'details': rdet.text,
                                    'status': 'Reported',
                                  });

                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: kc30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        title: const Text(
                                          'Error',
                                          style: TextStyle(color: kc60),
                                        ),
                                        content: Text(e.toString(),
                                            style:
                                                const TextStyle(color: kc60)),
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
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      title: const Text(
                                        'Error',
                                        style: TextStyle(color: kc60),
                                      ),
                                      content: const Text(
                                        'Fields must be filled',
                                        style: TextStyle(color: kc60),
                                      ),
                                    );
                                  });
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const UpdateProfile()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kc30),
                            // elevation: MaterialStateProperty.all(4.0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Report Work',
                            style: TextStyle(
                                color: Colors.white,
                                shadows: kshadow2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
