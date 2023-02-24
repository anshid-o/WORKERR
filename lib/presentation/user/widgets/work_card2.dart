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
  List<String> workers = ['Choose One'];
  List<String> workersId = [];
  List<int> workersCount = [];
  List<double> workersRating = [];
  String review = '';
  List<String> status = [
    'Requested',
    'Accepted',
    'Completed',
    'Failed',
  ];
  // List<IconData> wicons = [CupertinoIcons.projective];

  int stars = 0;
  bool isCRated = false;
  String selectedStatus = 'Requested';

  String selectedItem = 'Choose One';
  TextEditingController kreview = TextEditingController();

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

  bool isPressed = false;

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  getData() async {
    await firebase
        .collection("Requests")
        .where('id', isEqualTo: widget.myDoc.id)
        .where('status', isEqualTo: 'Accepted')
        .get()
        .then((querySnapshot) {
      final names = querySnapshot.docs
          .map((document) => document.data()['toName'].toString())
          .toList();
      if (mounted) {
        setState(() {
          widget.workers = widget.workers + names;
        });
      }
      final ids = querySnapshot.docs
          .map((document) => document.data()['to'].toString())
          .toList();
      if (mounted) {
        widget.workersId = widget.workersId + ids;
      }
      final counts = querySnapshot.docs
          .map((document) => int.parse(document.data()['count'].toString()))
          .toList();
      if (mounted) {
        setState(() {
          widget.workersCount = widget.workersCount + counts;
        });
      }
      final rt = querySnapshot.docs
          .map((document) => double.parse(document.data()['rating'].toString()))
          .toList();
      if (mounted) {
        setState(() {
          widget.workersRating = widget.workersRating + rt;
        });
      }
    });
    var w = await firebase.collection('Works').doc(widget.myDoc.id).get();
    if (mounted) {
      setState(() {
        widget.isCRated = w['cRate'];
      });
    }
  }

  void initState() {
    // TODO: implement initState

    getData();
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
                                  widget.isCRated
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Rated',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        )
                                      : ElevatedButton.icon(
                                          onPressed: () {
                                            updateStatus(context, document.id);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ))),
                                          icon: const Icon(Icons.add),
                                          label: const Text(
                                            'Rate Client',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
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
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),

                    // wrap with GlassText
                    child: widget.isClient
                        ? Column(
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  width: 4, color: kblue3))),
                                      value: widget.selectedStatus,
                                      items: widget.status
                                          .map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (item) {
                                        if (mounted) {
                                          setState(() {
                                            widget.selectedStatus = item!;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              kheight,
                              if (widget.selectedStatus != 'Requested')
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    width: 4, color: kblue3))),
                                        value: widget.selectedItem,
                                        items: widget.workers
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedItem = item!;
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              kheight,
                              if (widget.selectedStatus == 'Completed')
                                Column(
                                  children: [
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
                                              if (mounted) {
                                                setState(() {
                                                  widget.stars = 1;
                                                });
                                              }
                                            },
                                            icon: widget.stars > 0
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
                                              if (mounted) {
                                                setState(() {
                                                  widget.stars = 2;
                                                });
                                              }
                                            },
                                            icon: widget.stars > 1
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
                                              if (mounted) {
                                                setState(() {
                                                  widget.stars = 3;
                                                });
                                              }
                                            },
                                            icon: widget.stars > 2
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
                                              if (mounted) {
                                                setState(() {
                                                  widget.stars = 4;
                                                });
                                              }
                                            },
                                            icon: widget.stars > 3
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
                                              if (mounted) {
                                                setState(() {
                                                  widget.stars = 5;
                                                });
                                              }
                                            },
                                            icon: widget.stars > 4
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
                                  ],
                                ),
                              kheight,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (widget.selectedStatus == 'Completed')
                                    ElevatedButton.icon(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Tell about Worker',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: TextFormField(
                                                  controller: widget.kreview,
                                                  minLines: 3,
                                                  maxLines: 5,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      label: const Text(
                                                          'Enter review')),
                                                ),
                                                actions: [
                                                  ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .green)),
                                                      onPressed: () {
                                                        if (mounted) {
                                                          setState(() {
                                                            widget.review =
                                                                widget.kreview
                                                                    .text;
                                                          });
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.done),
                                                      label: const Text('Add')),
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
                                                      icon: const Icon(
                                                          Icons.close),
                                                      label: const Text(
                                                          'Discard')),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: widget.review == ''
                                            ? const Icon(Icons.reviews)
                                            : const Icon(Icons.done),
                                        label: const Text('Add review')),
                                  Container(
                                    width: 115,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: kc10,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: TextButton(
                                        onHover: (hovered) {
                                          if (mounted) {
                                            setState(() {
                                              isPressed = hovered;
                                            });
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.white, width: 3),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // await Future.delayed(const Duration(milliseconds: 800));
                                          widget.workers.length > 1
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      title:
                                                          const Text('Remider'),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      content: const Text(
                                                          'Are you sure, you want to update the status ?'),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      actions: [
                                                        ElevatedButton.icon(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .green)),
                                                            onPressed: () {
                                                              final user =
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!;

                                                              for (int i = 0;
                                                                  i <
                                                                      widget
                                                                          .workers
                                                                          .length;
                                                                  i++) {
                                                                if (widget.workers[
                                                                        i] ==
                                                                    widget
                                                                        .selectedItem) {
                                                                  inx = i - 1;
                                                                }
                                                              }

                                                              double xp = double.parse(((widget.workersRating[inx] *
                                                                              widget.workersCount[
                                                                                  inx] +
                                                                          widget
                                                                              .stars) /
                                                                      (widget.workersCount[
                                                                              inx] +
                                                                          1))
                                                                  .toDouble()
                                                                  .toStringAsPrecision(
                                                                      2));
                                                              if (widget
                                                                      .selectedStatus ==
                                                                  'Accepted') {
                                                                firebase
                                                                    .collection(
                                                                        "Works")
                                                                    .doc(id)
                                                                    .update({
                                                                  'status': widget
                                                                      .selectedStatus,
                                                                  'worker': widget
                                                                      .selectedItem,
                                                                  'wid': widget
                                                                          .workersId[
                                                                      inx],
                                                                });
                                                              }

                                                              if (widget
                                                                      .selectedStatus ==
                                                                  'Completed') {
                                                                firebase
                                                                    .collection(
                                                                        "Workers")
                                                                    .doc(widget
                                                                            .workersId[
                                                                        inx])
                                                                    .update({
                                                                  'rating': xp,
                                                                  'count': FieldValue
                                                                      .increment(
                                                                          1),
                                                                });
                                                                firebase
                                                                    .collection(
                                                                        'Reviews')
                                                                    .doc()
                                                                    .set({
                                                                  'uid':
                                                                      user.uid,
                                                                  'wid': widget
                                                                      .myDoc.id,
                                                                  'review': widget
                                                                      .review,
                                                                  'time':
                                                                      DateTime
                                                                          .now()
                                                                });
                                                                firebase
                                                                    .collection(
                                                                        "Works")
                                                                    .doc(id)
                                                                    .update({
                                                                  'status': widget
                                                                      .selectedStatus,
                                                                  'worker': widget
                                                                      .selectedItem,
                                                                  'wid': widget
                                                                          .workersId[
                                                                      inx],
                                                                  'rating':
                                                                      widget
                                                                          .stars,
                                                                  'review':
                                                                      widget
                                                                          .review
                                                                });
                                                                firebase
                                                                    .collection(
                                                                        'Requests')
                                                                    .get()
                                                                    .then(
                                                                        (querySnapshot) {
                                                                  querySnapshot
                                                                      .docs
                                                                      .forEach(
                                                                          (document) {
                                                                    if (document[
                                                                            'id'] ==
                                                                        id) {
                                                                      document
                                                                          .reference
                                                                          .update({
                                                                        'rating':
                                                                            xp,
                                                                        'count':
                                                                            FieldValue.increment(1)
                                                                      });
                                                                    }
                                                                  });
                                                                });

                                                                widget.workersCount[
                                                                        inx] =
                                                                    widget.workersCount[
                                                                            inx] +
                                                                        1;
                                                                widget.workersRating[
                                                                    inx] = xp;
                                                              }

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                                Icons.done),
                                                            label: const Text(
                                                                'Yes')),
                                                        ElevatedButton.icon(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .red)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              updateStatus(
                                                                  context,
                                                                  widget.myDoc
                                                                      .id);
                                                            },
                                                            icon: const Icon(
                                                                Icons.close),
                                                            label: const Text(
                                                                'No')),
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
                                          onPointerDown: (event) {
                                            if (mounted) {
                                              setState(() {
                                                isPressed = true;
                                              });
                                            }
                                          },
                                          onPointerUp: (event) {
                                            if (mounted) {
                                              setState(() {
                                                isPressed = false;
                                              });
                                            }
                                          },
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
                                                        i <
                                                            (isPressed
                                                                ? 10
                                                                : 6);
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
                          )
                        : Column(
                            children: [
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
                                        if (mounted) {
                                          setState(() {
                                            widget.stars = 1;
                                          });
                                        }
                                      },
                                      icon: widget.stars > 0
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
                                        if (mounted) {
                                          setState(() {
                                            widget.stars = 2;
                                          });
                                        }
                                      },
                                      icon: widget.stars > 1
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
                                        if (mounted) {
                                          setState(() {
                                            widget.stars = 3;
                                          });
                                        }
                                      },
                                      icon: widget.stars > 2
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
                                        if (mounted) {
                                          setState(() {
                                            widget.stars = 4;
                                          });
                                        }
                                      },
                                      icon: widget.stars > 3
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
                                        if (mounted) {
                                          setState(() {
                                            widget.stars = 5;
                                          });
                                        }
                                      },
                                      icon: widget.stars > 4
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
                              ElevatedButton(
                                  onPressed: () async {
                                    var a = await firebase
                                        .collection('Users')
                                        .doc(id)
                                        .get();
                                    var crate = a['rating'];
                                    var ccount = a['count'];
                                    var xp = double.parse(
                                        ((crate * ccount + widget.stars) /
                                                (ccount + 1))
                                            .toDouble()
                                            .toStringAsPrecision(2));
                                    firebase
                                        .collection('Users')
                                        .doc(id)
                                        .update({
                                      'count': FieldValue.increment(1),
                                      'rating': xp,
                                    });
                                    firebase
                                        .collection('Works')
                                        .doc(widget.myDoc.id)
                                        .update({'cRate': true});
                                    Navigator.pop(context);
                                    showDone(context, 'Rated successfully',
                                        Icons.done, Colors.green);
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ))),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text('Rate'),
                                  ))
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        });
  }
}
