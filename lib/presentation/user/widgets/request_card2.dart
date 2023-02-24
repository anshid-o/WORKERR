import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/widgets/chat_screen2.dart';

class RequestCard2 extends StatefulWidget {
  DocumentSnapshot myDoc;

  RequestCard2({
    Key? key,
    required this.myDoc,
  }) : super(key: key);

  @override
  State<RequestCard2> createState() => _RequestCard2State();
}

class _RequestCard2State extends State<RequestCard2> {
  final storeUser = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser!;

  int isChoose = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: storeUser
          .collection("Users")
          .where("uid", isEqualTo: widget.myDoc['from'])
          .snapshots(),
      // .where({"status", "is", "Requested"}).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                // child: CircularProgressIndicator(
                //   value: 60,
                //   backgroundColor: kc60,
                // ),
                );
          default:
            DocumentSnapshot document = snapshot.data!.docs[0];
            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kc602,
                          // gradient: kmygd,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // color: Colors.white,
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            radius: size.width * .08,
                            backgroundColor: kc30,
                            backgroundImage: image,
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 15),
                            child: IconButton(
                              tooltip: 'Send Message to ${document['name']}',
                              // alignment: Alignment.topRight,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ChatScreen2(
                                            phone: document['phone'],
                                            img: image,
                                            id: document['uid'],
                                            name: document['name'],
                                          )),
                                );
                              },
                              icon: const Icon(
                                CupertinoIcons.quote_bubble_fill,
                                size: 30,
                                color: kc10,
                                shadows: kshadow2,
                              ),
                            ),
                          ),
                          title: Text(
                            widget.myDoc['job'],
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: kc30,
                                letterSpacing: 1),
                          ),
                          subtitle: Text(
                            widget.myDoc['date'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kc302,
                            ),
                          ),
                          children: [
                            kheight,
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                widget.myDoc['details'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: kc302,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            kheight,
                            Text(
                              'By : ${document['name']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kc30,
                              ),
                            ),
                            kheight,
                            Text(
                              // snapshot.data!.docs.contains('place')
                              //     ?
                              'From :${document['place']}',
                              // : 'From :${document['pin']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kc30,
                              ),
                            ),
                            kheight,
                            Text(
                              // snapshot.data!.docs.contains('place')
                              //     ?
                              'Rating :${document['rating']} ( Count :${document['count']})',
                              // : 'From :${document['pin']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kc30,
                              ),
                            ),
                            kheight,
                            if (widget.myDoc['status'] == 'Requested')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              title: const Text('Remider'),
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              content: const Text(
                                                  'Are you sure, you want to update the status ?'),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              actions: [
                                                ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .green)),
                                                    onPressed: () {
                                                      setState(() {
                                                        isChoose = 1;
                                                      });
                                                      storeUser
                                                          .collection(
                                                              "Requests")
                                                          .doc(widget.myDoc.id)
                                                          .update({
                                                        'status': 'Accepted',
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.done),
                                                    label: const Text('Yes')),
                                                ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // updateStatus(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                    label: const Text('No')),
                                              ],
                                            );
                                          },
                                        );

                                        // Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.done),
                                      label: const Text('Accept')),
                                  ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              title: const Text('Remider'),
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              content: const Text(
                                                  'Are you sure, you want to update the status ?'),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              actions: [
                                                ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .green)),
                                                    onPressed: () {
                                                      setState(() {
                                                        isChoose = 2;
                                                      });
                                                      storeUser
                                                          .collection(
                                                              "Requests")
                                                          .doc(widget.myDoc.id)
                                                          .update({
                                                        'status': 'Rejected',
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.done),
                                                    label: const Text('Yes')),
                                                ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // updateStatus(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                    label: const Text('No')),
                                              ],
                                            );
                                          },
                                        );

                                        // Navigator.pop(context);
                                        // updateStatus(context);
                                      },
                                      icon: const Icon(Icons.close),
                                      label: const Text('Reject')),
                                ],
                              )
                            else if (widget.myDoc['status'] == 'Accepted')
                              const Text(
                                'Accepted',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            else
                              const Text(
                                'Rejected',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            kheight
                          ],
                        ),
                      ),
                    ),
                  )

                //  WorkCard2(
                //   index: index,
                //   date: document['date'],
                //   work: document['work'],
                //   details: document['details'],
                // );

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
