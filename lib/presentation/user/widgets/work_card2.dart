// import 'dart:html';
// import 'dart:html';
import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/home/my%20works/works.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

import '../screens/main/chat/widgets/chat_screen2.dart';

class WorkCard2 extends StatefulWidget {
  int index;
  DocumentSnapshot myDoc;
  // String id;
  bool isClient;
  // String work;
  // String date;
  // String details;
  WorkCard2(
      {Key? key,
      required this.myDoc,
      this.isClient = true,
      // required this.work,
      // required this.id,
      // required this.date,
      // required this.details,
      required this.index})
      : super(key: key);

  @override
  State<WorkCard2> createState() => _WorkCard2State();
}

class _WorkCard2State extends State<WorkCard2> {
  // List<Wworks> usersList = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   fetchRecords();
  //   super.initState();
  // }

  // fetchRecords() async {
  //   var records = await FirebaseFirestore.instance.collection('Users').get();
  //   mapRecords(records);
  // }

  // mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
  //   var rusers = records.docs
  //       .map((item) => Wworks(
  //           details: item['details'],
  //           status: item['status'],
  //           date: item['date'],
  //           work: item['work'],
  //           uid: item['uid']))
  //       .toList();

  //   setState(() {
  //     usersList = rusers;
  //   });
  // }
  List<String> workers = ['Choose One'];
  List<String> workersId = [];
  List<int> workersCount = [];
  List<double> workersRating = [];

  List<String> status = [
    'Requested',
    'Accepted',
    'Completed',
    'Failed',
  ];
  // List<IconData> wicons = [CupertinoIcons.projective];

  int stars = 0;
  String selectedStatus = 'Requested';

  String selectedItem = 'Choose One';

  bool isPressed = false;

  void initState() {
    // TODO: implement initState
    firebase
        .collection("Requests")
        .where('id', isEqualTo: widget.myDoc.id)
        .where('status', isEqualTo: 'Accepted')
        .get()
        .then((querySnapshot) {
      final names = querySnapshot.docs
          .map((document) => document.data()['toName'].toString())
          .toList();
      workers = workers + names;
      final ids = querySnapshot.docs
          .map((document) => document.data()['to'].toString())
          .toList();
      workersId = workersId + ids;
      final counts = querySnapshot.docs
          .map((document) => int.parse(document.data()['count'].toString()))
          .toList();
      workersCount = workersCount + counts;
      final rt = querySnapshot.docs
          .map((document) => double.parse(document.data()['rating'].toString()))
          .toList();
      workersRating = workersRating + rt;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebase
          .collection("Users")
          .where("uid", isEqualTo: widget.myDoc['uid'])
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
            DocumentSnapshot document = snapshot.data!.docs[0];
            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: kc602,
                      // gradient: kmygd,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // color: Colors.white,
                    child: ExpansionTile(
                      // collapsedBackgroundColor: Colors.yellow,
                      title: Text(
                        widget.myDoc['work'],
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: kc30,
                            letterSpacing: 1),
                      ),
                      leading: widget.index < 10
                          ? Text(
                              '0${widget.index + 1}',
                              style: const TextStyle(
                                // color: kc30,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              '${widget.index + 1}',
                              style: const TextStyle(
                                // color: kc30,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                      trailing: widget.isClient
                          ? IconButton(
                              tooltip: 'Update Status',
                              onPressed: () {
                                updateStatus(context, widget.myDoc.id);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => UpdateStatus(),
                                //   ),
                                // );
                              },
                              icon: const Icon(
                                CupertinoIcons.news,
                                color: kc10,
                                size: 30,
                                shadows: [
                                  Shadow(
                                      color: kc10,
                                      offset: Offset(2, 0),
                                      blurRadius: 15)
                                ],
                              ),
                            )
                          : IconButton(
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
                              icon:
                                  const Icon(CupertinoIcons.chat_bubble_2_fill),
                              color: kc10,
                              iconSize: 30,
                            ),
                      subtitle: Text(
                        widget.myDoc['date'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kc30,
                        ),
                      ),
                      // backgroundColor: Colors.cyan,
                      children: [
                        widget.isClient
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.myDoc['details'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: kc30,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.myDoc['details'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: kc30,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  kheight,
                                  Text(
                                    'By ${document['name']}',
                                    style: const TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  kheight,
                                  Text(
                                    'From ${document['place']}',
                                    style: const TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  kheight,
                                  Text(
                                    'Contact @ ${document['phone']}',
                                    style: const TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  kheight,
                                ],
                              ),
                      ],
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

  Future<dynamic> updateStatus(BuildContext context, String id) {
    final size = MediaQuery.of(context).size;
    int inx = 0;
    return showModalBottomSheet(
        backgroundColor: kc602,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
                child: Container(
                  padding: const EdgeInsets.all(16),

                  // wrap with GlassText
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Choose Status :',
                            style: TextStyle(
                                color: kc30,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          ksize(y: 8),
                          SizedBox(
                            width: 200,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          width: 4, color: kblue3))),
                              value: selectedStatus,
                              items: status
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectedStatus = item!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      kheight,
                      if (selectedStatus != 'Requested')
                        Row(
                          children: [
                            const Text(
                              'Choose Worker :',
                              style: TextStyle(
                                  color: kc30,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            ksize(y: 3),
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            width: 4, color: kblue3))),
                                value: selectedItem,
                                items: workers
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(fontSize: 15),
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
                      kheight,
                      if (selectedStatus == 'Completed')
                        Row(
                          children: [
                            const Text(
                              'Rate :',
                              style: TextStyle(
                                  color: kc30,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    stars = 1;
                                  });
                                },
                                icon: stars > 0
                                    ? const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: kgold,
                                        shadows: kshadow2,
                                      )
                                    : const Icon(
                                        Icons.star_border,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    stars = 2;
                                  });
                                },
                                icon: stars > 1
                                    ? const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: kgold,
                                        shadows: kshadow2,
                                      )
                                    : const Icon(
                                        Icons.star_border,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    stars = 3;
                                  });
                                },
                                icon: stars > 2
                                    ? const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: kgold,
                                        shadows: kshadow2,
                                      )
                                    : const Icon(
                                        Icons.star_border,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    stars = 4;
                                  });
                                },
                                icon: stars > 3
                                    ? const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: kgold,
                                        shadows: kshadow2,
                                      )
                                    : const Icon(
                                        Icons.star_border,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    stars = 5;
                                  });
                                },
                                icon: stars > 4
                                    ? const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: kgold,
                                        shadows: kshadow2,
                                      )
                                    : const Icon(
                                        Icons.star_border,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                          ],
                        ),
                      kheight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ksize(y: 85),
                          Container(
                            width: 115,
                            height: 45,
                            decoration: BoxDecoration(
                                color: kc10,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: TextButton(
                                onHover: (hovered) => setState(() {
                                  isPressed = hovered;
                                }),
                                style: TextButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.white, width: 3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // await Future.delayed(const Duration(milliseconds: 800));
                                  workers.length > 1
                                      ? showDialog(
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
                                                      final user = FirebaseAuth
                                                          .instance
                                                          .currentUser!;

                                                      for (int i = 0;
                                                          i < workers.length;
                                                          i++) {
                                                        if (workers[i] ==
                                                            selectedItem) {
                                                          inx = i - 1;
                                                        }
                                                      }

                                                      double xp = double.parse(
                                                          ((workersRating[inx] *
                                                                          workersCount[
                                                                              inx] +
                                                                      stars) /
                                                                  (workersCount[
                                                                          inx] +
                                                                      1))
                                                              .toDouble()
                                                              .toStringAsPrecision(
                                                                  2));

                                                      if (selectedStatus ==
                                                          'Completed') {
                                                        firebase
                                                            .collection(
                                                                "Workers")
                                                            .doc(workersId[inx])
                                                            .update({
                                                          'rating': xp,
                                                          'count': FieldValue
                                                              .increment(1),
                                                        });
                                                        firebase
                                                            .collection("Works")
                                                            .doc(id)
                                                            .update({
                                                          'status':
                                                              selectedStatus,
                                                          'worker':
                                                              selectedItem,
                                                          'wid': workersId[inx],
                                                          'rating': stars,
                                                        });
                                                        firebase
                                                            .collection(
                                                                'Requests')
                                                            .get()
                                                            .then(
                                                                (querySnapshot) {
                                                          querySnapshot.docs
                                                              .forEach(
                                                                  (document) {
                                                            if (document[
                                                                    'id'] ==
                                                                id) {
                                                              document.reference
                                                                  .update({
                                                                'rating': xp,
                                                                'count': FieldValue
                                                                    .increment(
                                                                        1)
                                                              });
                                                            }
                                                          });
                                                        });

                                                        workersCount[inx] =
                                                            workersCount[inx] +
                                                                1;
                                                        workersRating[inx] = xp;
                                                      }

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
                                                      updateStatus(context,
                                                          widget.myDoc.id);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                    label: const Text('No')),
                                              ],
                                            );
                                          },
                                        )
                                      : showDone(
                                          context,
                                          'please choose a worker',
                                          Icons.error,
                                          Colors.red);
                                },
                                onLongPress: () {
                                  // Navigator.pop(context);
                                },
                                child: Listener(
                                  onPointerDown: (event) => setState(() {
                                    isPressed = true;
                                  }),
                                  onPointerUp: (event) => setState(() {
                                    isPressed = false;
                                  }),
                                  child: SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          shadows: [
                                            for (double i = 1;
                                                i < (isPressed ? 10 : 6);
                                                i++)
                                              const Shadow(
                                                color: kshadowColor,
                                                blurRadius: 3,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
