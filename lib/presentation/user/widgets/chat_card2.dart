import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/widgets/chat_screen2.dart';

class ChatCard2 extends StatelessWidget {
  String uid;
  int index;
  ChatCard2({Key? key, required this.uid, required this.index})
      : super(key: key);
  final storeUser = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: storeUser
          .collection("Users")
          .where("uid", isEqualTo: uid)
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
                          // gradient: kc30gd,
                          color: kc602,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // color: Colors.white,
                        child: ListTile(
                          // childrenPadding: const EdgeInsets.all(10),
                          title: Text(
                            document['name'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: kc30,
                            backgroundImage: image,
                          ),
                          subtitle: Text(
                            '${(index + 4) * 2}/${index + 1}/2021',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ChatScreen2(
                                            phone: document['phone'],
                                            img: image,
                                            id: document['uid'],
                                            name: document['name'],
                                          )));
                            },
                            icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
                            color: kc10,
                            iconSize: 30,
                          ),
                          // children: const [
                          //   Padding(
                          //     padding: EdgeInsets.all(8.0),
                          //     child: Text(
                          //       'Hello, I am intrested to do the plumbing work.\nCan you call me when you are free ?',
                          //       textAlign: TextAlign.left,
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ],
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
