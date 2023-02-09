import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/admin/screens/feedback/feedback_reply.dart';
// import 'package:workerr_app/presentation/admin/screens/Feedback/admin_reply.dart';

class FeedbackCard2 extends StatelessWidget {
  String uid;
  String id;
  String date;
  String feedback;
  int state;
  FeedbackCard2(
      {Key? key,
      required this.date,
      required this.id,
      required this.feedback,
      required this.state,
      required this.uid})
      : super(key: key);
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String states;
    switch (state) {
      case 1:
        states = 'Very Bad';
        break;
      case 2:
        states = 'Poor';
        break;
      case 3:
        states = 'Medium';
        break;
      case 4:
        states = 'Good';
        break;
      case 5:
      default:
        states = 'Excellent';
    }
    return StreamBuilder<QuerySnapshot>(
      stream:
          firebase.collection("Users").where("uid", isEqualTo: uid).snapshots(),
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
            DocumentSnapshot document = snapshot.data!.docs[0];
            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kc602,
                        // gradient: kmygd,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          states,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                              letterSpacing: 0),
                        ),
                        subtitle: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kc302,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: image,
                        ),
                        // trailing: const CircleAvatar(
                        //   radius: 16,
                        //   backgroundColor: kc10,
                        //   child: Icon(CupertinoIcons.)
                        // ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 18, 18, 5),
                            child: Text(
                              feedback,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '- ${document['name']}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              kwidth20,
                              kwidth30
                            ],
                          ),
                          kheight20,
                          // kheight30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kc30),
                                    // elevation: MaterialStateProperty.all(4.0),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FeedbackReply(
                                            uid: uid,
                                            id: id,
                                            state: state,
                                          ),
                                        ));
                                  },
                                  child: const Text(
                                    'Give Reply',
                                    style: TextStyle(
                                        color: kc10,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          kheight
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kc60, borderRadius: BorderRadius.circular(20)),
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
                  );
        }
      },
    );
  }
}
