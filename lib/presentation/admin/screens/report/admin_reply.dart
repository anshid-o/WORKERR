import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class AdminReply extends StatelessWidget {
  String uid;
  String subject;
  String id;
  AdminReply(
      {Key? key, required this.uid, required this.id, required this.subject})
      : super(key: key);

  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;
  TextEditingController kreply = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: kc30,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: AppBar(
              // surfaceTintColor: kc302,
              backgroundColor: kc30.withGreen(18),
              // automaticallyImplyLeading: false,
              title: const Text(
                'Give Reply',
                style: TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                kheight,
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.mail,
                    color: kc60,
                    shadows: kshadow2,
                    size: 70,
                  ),
                ),
                const Divider(
                  thickness: 0,
                  height: 0,
                ),
                Container(
                  width: size.width - 30,
                  height: size.width - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      gradient: const SweepGradient(
                          tileMode: TileMode.repeated,
                          center: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Color.fromARGB(255, 228, 222, 222),
                            Colors.white
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Subject : $subject',
                              // textAlign: TextAlign.start,
                              style: const TextStyle(
                                // fontStyle: FontStyle.italic,
                                // backgroundColor: kgold,
                                color: kc10,
                                decoration: TextDecoration.underline,
                                decorationColor: kc30,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                // decoration: TextDecoration.underline,
                                // decorationThickness: 1.3,
                                // decorationColor: kred,
                              ),
                            ),
                          ],
                        ),
                        kheight30,
                        kheight20,
                        const Text(
                          "Enter Response",
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

                        kheight20,

                        // MyTextForm(
                        //     name: 'Work', icon: Icons.work_outline_rounded),
                        kheight30,
                        kheight,
                        TextFormField(
                          controller: kreply,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kc10.withOpacity(.1),
                            label: const Text(
                              'Reply',
                              textAlign: TextAlign.start,
                            ),
                            prefixIcon: const Icon(CupertinoIcons.info),
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

                        // kheight30,
                      ],
                    ),
                  ),
                ),
                kheight20,
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      if (kreply.text.isNotEmpty) {
                        try {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            // print('user not null');
                            final now = DateTime.now();
                            String formatter = DateFormat('yMd').format(now);
                            storeUser.collection("Responses").doc().set({
                              'uid': uid,
                              'subject': subject,
                              'date': formatter,
                              'status': 'Responded',
                              'details': kreply.text,
                            });
                            storeUser
                                .collection("Reports")
                                .doc(id)
                                .update({'status': 'Responded'});

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
                                  'Fields must be filled',
                                  style: TextStyle(color: kc60),
                                ),
                              );
                            });
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kc10),
                      // elevation: MaterialStateProperty.all(4.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Send Reply',
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
          )),
    );
  }
}
