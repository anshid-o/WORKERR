import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/update_work.dart';
// import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class ScreenSpacifyWork extends StatelessWidget {
  String name;
  String pincode;
  String district;
  ScreenSpacifyWork(
      {Key? key,
      required this.district,
      required this.pincode,
      required this.name})
      : super(key: key);
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

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
        title: Row(children: const [
          SizedBox(
            width: 25,
          ),
          Text(
            'Update Work Details',
            style: TextStyle(
              color: kc60,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebase
            .collection("Workers")
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        // .where({"status", "is", "Requested"}).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  value: 60,
                  backgroundColor: kc60,
                ),
              );
            default:
              return snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = snapshot.data!.docs[0];
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: kc602,
                                  radius: 40,
                                  child: Icon(
                                    Icons.workspace_premium_outlined,
                                    shadows: kshadow2,
                                    size: 60,
                                  ),
                                ),
                                ksize(x: 40),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: kwhitegd2
                                        // color: const Color.fromARGB(255, 255, 234, 234),
                                        ),
                                    child: ExpansionTile(
                                      initiallyExpanded: true,
                                      title: const Center(
                                        child: Text(
                                          'Status of Previous Update',
                                          style: TextStyle(
                                              color: kc30,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Center(
                                        child: Text(
                                          'Work : ${document['job']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(document['details'],
                                              style: ktextStyle),
                                        ),
                                        kheight,
                                        Text(
                                          'Experience : ${document['experience']}',
                                          style: ktextStyle,
                                        ),
                                        kheight,
                                        Text(
                                          'Date : ${document['date']}',
                                          style: ktextStyle,
                                        ),
                                        kheight,
                                        Text(
                                          'Status : ${document['status']}',
                                          style: ktextStyle,
                                        ),
                                        kheight
                                      ],
                                    ),
                                  ),
                                ),
                                kheight30,
                                Form(
                                  child: Column(
                                    children: [
                                      // MyTextForm(
                                      //   name: 'Work',
                                      //   icon: Icons.work_outline,
                                      //   type: TextInputType.name,
                                      // ),
                                      // kheight20,
                                      // MyTextForm(
                                      //     name: 'Experience', icon: Icons.group_work_outlined),
                                      // kheight20,
                                      // TextFormField(
                                      //   minLines: 1,
                                      //   maxLines: 5,
                                      //   decoration: InputDecoration(
                                      //     filled: true,
                                      //     fillColor: kc60.withOpacity(.2),
                                      //     label: const Text(
                                      //       'Details',
                                      //       style: TextStyle(color: kc10),
                                      //       textAlign: TextAlign.start,
                                      //     ),
                                      //     prefixIcon: const Icon(
                                      //       Icons.details_rounded,
                                      //       color: kc10,
                                      //     ),
                                      //     enabledBorder: const UnderlineInputBorder(
                                      //       borderSide: BorderSide(color: kc10, width: 2.0),
                                      //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      //     ),
                                      //     hintStyle: const TextStyle(
                                      //         color: Color.fromARGB(255, 54, 9, 62)),
                                      //     focusedBorder: const UnderlineInputBorder(
                                      //       borderSide: BorderSide(color: kc10, width: 3.0),
                                      //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      //     ),
                                      //     border: const UnderlineInputBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(10.0),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                      // remining

                                      kheight30,
                                      SizedBox(
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateWork(
                                                          district: district,
                                                          pincode: pincode,
                                                          name: name,
                                                        )));
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    kc602),
                                            // elevation: MaterialStateProperty.all(4.0),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Update Work',
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                kheight30,
                              ],
                            ),
                          ),
                        );

                        //  WorkCard2(
                        //   index: index,
                        //   date: document['date'],
                        //   work: document['work'],
                        //   details: document['details'],
                        // );
                      },
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kc60,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'You are not posted any works yet.',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: kc30,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        kheight30,
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateWork(
                                            district: district,
                                            pincode: pincode,
                                            name: name,
                                          )));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(kc602),
                              // elevation: MaterialStateProperty.all(4.0),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Update Work',
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
          }
        },
      ),
    );
  }
}
