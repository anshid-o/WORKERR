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

class WorkCard2 extends StatefulWidget {
  int index;
  String id;
  String work;
  String date;
  String details;
  WorkCard2(
      {Key? key,
      required this.work,
      required this.id,
      required this.date,
      required this.details,
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
  List<int> workersRating = [];

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kc602,
        // gradient: kmygd,
        borderRadius: BorderRadius.circular(15),
      ),
      // color: Colors.white,
      child: ExpansionTile(
        // collapsedBackgroundColor: Colors.yellow,
        title: Text(
          widget.work,
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

        //const Icon(
        //   CupertinoIcons.paintbrush_fill,
        //   // shadows: [
        //   //   Shadow(
        //   //       color: Color.fromARGB(255, 213, 140, 255),
        //   //       offset: Offset(2, 2),
        //   //       blurRadius: 3)
        //   // ],
        //   size: 30,
        //   color: kc30,
        // ),
        trailing: IconButton(
          tooltip: 'Update Status',
          onPressed: () {
            updateStatus(context, widget.id);
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
              Shadow(color: kc10, offset: Offset(2, 0), blurRadius: 15)
            ],
          ),
        ),
        subtitle: Text(
          widget.date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kc30,
          ),
        ),
        // backgroundColor: Colors.cyan,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.details,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: kc30, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
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
                        StreamBuilder<QuerySnapshot>(
                          stream: firebase
                              .collection("Requests")
                              .where("id", isEqualTo: id)
                              .snapshots(),
                          // .where({"status", "is", "Requested"}).snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const Center(
                                    // child: CircularProgressIndicator(
                                    //   value: 60,
                                    //   backgroundColor: kc60,
                                    // ),
                                    );
                              default:
                                List<DocumentSnapshot> document =
                                    snapshot.data!.docs;

                                for (int i = 0; i < snapshot.data!.size; i++) {
                                  if (!workers
                                      .contains(document[i]['toName'])) {
                                    workers.add(document[i]['toName']);
                                    // workersId.add(document[i]['to']);
                                    // workersCount.add(document[i]['count']);
                                    // workersRating.add(document[i]['rating']);
                                  }
                                }
                                return snapshot.data!.docs.isNotEmpty
                                    ? Row(
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
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 4,
                                                                  color:
                                                                      kblue3))),
                                              value: selectedItem,
                                              items: workers
                                                  .map(
                                                    (item) => DropdownMenuItem<
                                                        String>(
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
                                                setState(() {
                                                  selectedItem = item!;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 100, 30, 0),
                                        child: null);
                            }
                          },
                        ),
                      kheight,
                      if (selectedStatus == 'Completed')
                        StreamBuilder<QuerySnapshot>(
                          stream: firebase
                              .collection("Requests")
                              .where("id", isEqualTo: id)
                              .snapshots(),
                          // .where({"status", "is", "Requested"}).snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const Center(
                                    // child: CircularProgressIndicator(
                                    //   value: 60,
                                    //   backgroundColor: kc60,
                                    // ),
                                    );
                              default:
                                List<DocumentSnapshot> document =
                                    snapshot.data!.docs;

                                for (int i = 0; i < snapshot.data!.size; i++) {
                                  if (!workers
                                      .contains(document[i]['toName'])) {
                                    // workers.add(document[i]['toName']);
                                    workersId.add(document[i]['to']);
                                    workersCount.add(document[i]['count']);
                                    workersRating.add(document[i]['rating']);
                                  }
                                }
                                return snapshot.data!.docs.isNotEmpty
                                    ? Row(
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
                                      )
                                    : const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 100, 30, 0),
                                        child: null);
                            }
                          },
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
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
                                                      MaterialStateProperty.all(
                                                          Colors.green)),
                                              onPressed: () {
                                                final user = FirebaseAuth
                                                    .instance.currentUser!;
                                                firebase
                                                    .collection("Works")
                                                    .doc(id)
                                                    .update({
                                                  'status': selectedStatus,
                                                  'worker': selectedItem,
                                                  'rating': stars,
                                                });
                                                for (int i = 0;
                                                    i < workers.length;
                                                    i++) {
                                                  if (workers[i] ==
                                                      selectedItem) {
                                                    inx = i;
                                                  }
                                                }
                                                if (selectedStatus ==
                                                    'Completed') {
                                                  firebase
                                                      .collection("Workers")
                                                      .doc(workersId[inx])
                                                      .update({
                                                    'rating': (workersRating[
                                                                    inx] *
                                                                workersCount[
                                                                    inx] +
                                                            stars) /
                                                        workersCount[inx],
                                                    'count':
                                                        workersCount[inx] + 1,
                                                  });
                                                }

                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.done),
                                              label: const Text('Yes')),
                                          ElevatedButton.icon(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                updateStatus(
                                                    context, widget.id);
                                              },
                                              icon: const Icon(Icons.close),
                                              label: const Text('No')),
                                        ],
                                      );
                                    },
                                  );
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
