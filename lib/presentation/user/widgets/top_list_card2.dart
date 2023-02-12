import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/screens/main/workers_list.dart';

class TopList2 extends StatefulWidget {
  int i;
  DocumentSnapshot myDoc;
  TopList2({
    required this.i,
    required this.myDoc,
    Key? key,
  }) : super(key: key);

  @override
  State<TopList2> createState() => _TopList2State();
}

class _TopList2State extends State<TopList2> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  // List<String> workers = [
  //   'Anshid O',
  //   'Yaseen',
  //   'Hisham',
  //   'Nijas Ali',
  //   'Sidheeq',
  //   'Junaid',
  //   'Althaf',
  //   'Adil',
  //   'Mishal',
  // ];
  // List<String> works2 = [
  //   'Plumbing',
  //   'Painting',
  //   'Fabrication works',
  //   'Electric repairs',
  //   'Mechanic',
  //   'Driver',
  //   'Plumbing',
  //   'Painting',
  //   'Fabrication works',
  // ];
  bool flag = false;
  void initState() {
    // TODO: implement initState
    final user = FirebaseAuth.instance.currentUser;
    final documentReference = FirebaseFirestore.instance
        .collection("Favorites")
        .doc('${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');

    documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        // The document exists
        final data = documentSnapshot.data();

        // You can now access the values stored in the document
        if (data!['status'] == true) {
          setState(() {
            flag = true;
          });
        } else {
          setState(() {
            flag = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int j;
    // for (j = 0; j < favWorkers.length; j++) {
    //   if (favWorkers[j].name == widget.myDoc['name']) {
    //     setState(() {
    //       flag = false;
    //     });
    //     break;
    //   }
    // }

    return StreamBuilder<QuerySnapshot>(
      stream: firebase
          .collection("Users")
          .where('uid', isEqualTo: widget.myDoc['uid'])
          .snapshots(),
      // .where({"status", "is", "Requested"}).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center();
          default:
            DocumentSnapshot document = snapshot.data!.docs[0];

            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: kgoldgd,
                          borderRadius: BorderRadius.circular(15)),
                      // color: Colors.white,
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          radius: 32,
                          backgroundImage: image,
                        ),
                        title: Text(
                          widget.myDoc['name'],
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                              letterSpacing: 0),
                        ),
                        subtitle: Text(
                          widget.myDoc['job'],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: kc30,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            // insertItem(workers[i]);
                            final user = FirebaseAuth.instance.currentUser;
                            final documentReference = FirebaseFirestore.instance
                                .collection("Favorites")
                                .doc(
                                    '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');

                            documentReference.get().then((documentSnapshot) {
                              if (documentSnapshot.exists) {
                                // The document exists
                                final data = documentSnapshot.data();

                                // You can now access the values stored in the document
                                if (data!['status'] == true) {
                                  (firebase
                                      .collection('Favorites')
                                      .doc(
                                          '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                                      .update({'status': false}));
                                  setState(() {
                                    flag = false;
                                  });
                                } else {
                                  firebase
                                      .collection('Favorites')
                                      .doc(
                                          '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                                      .update({'status': true});
                                  setState(() {
                                    flag = true;
                                  });
                                }
                              } else {
                                firebase
                                    .collection("Favorites")
                                    .doc(
                                        '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                                    .set({
                                  'status': true,
                                  'name': widget.myDoc['name'],
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'wid': widget.myDoc.id,
                                  'time': DateTime.now()
                                });
                                setState(() {
                                  flag = true;
                                });
                              }
                            });

                            // if (!flag) {
                            //   showDone(
                            //       context,
                            //       '${widget.myDoc['name']} removed from favorites',
                            //       Icons.error_outline,
                            //       Colors.red);
                            //   // if(checkDoc('Favorites','${FirebaseAuth.instance.currentUser!.uid}${document['uid']}')){

                            //   // }
                            //   firebase
                            //       .collection("Favorites")
                            //       .doc(
                            //           '${FirebaseAuth.instance.currentUser!.uid}${document['uid']}')
                            //       .update({
                            //     'status': flag,
                            //   });
                            //   // favWorkers.removeAt(j);
                            // }

                            // if (flag) {
                            //   final now = DateTime.now();

                            //   firebase
                            //       .collection("Favorites")
                            //       .doc(
                            //           '${FirebaseAuth.instance.currentUser!.uid}${document['uid']}')
                            //       .set({
                            //     'uid': FirebaseAuth.instance.currentUser!.uid,
                            //     'wid': document['uid'],
                            //     'status': !flag,
                            //     'time': now,
                            //   });
                            //   // favWorkers
                            //   //     .add(FavWorkers(name: widget.myDoc['name']));
                            //   showDoneTop(context, widget.myDoc['name']);
                            // }
                            // setState(() {
                            //   flag = !flag;
                            // });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (ctx) => const MyTabbedAppBar(),
                            //   ),
                            // );
                          },
                          icon: flag
                              ? const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: kred,
                                  shadows: kshadow,
                                )
                              : const Icon(
                                  CupertinoIcons.heart,
                                  color: kred,
                                  shadows: kshadow,
                                ),
                        ),
                        children: [
                          ksize(y: 5),
                          Text(
                            'Rating : ${widget.myDoc['rating']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kc30),
                          ),
                          ksize(y: 5),
                          Text(
                            'Experience : ${widget.myDoc['name']}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kc30),
                          ),
                          Text(
                            document['place'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                            ),
                          ),
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

void showDoneTop(BuildContext ctx, String name) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Row(
      children: [
        Text(
          '$name is added to favorite list',
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        kwidth,
        const Icon(
          Icons.favorite_rounded,
          color: Colors.red,
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  ));
}
