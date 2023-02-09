import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class WaitingCard2 extends StatefulWidget {
  String uid;

  String work;
  String date;
  String desc;
  String exp;
  WaitingCard2(
      {Key? key,
      required this.work,
      required this.date,
      required this.desc,
      required this.uid,
      required this.exp})
      : super(key: key);

  @override
  State<WaitingCard2> createState() => _WaitingCard2State();
}

class _WaitingCard2State extends State<WaitingCard2> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  // final user = FirebaseAuth.instance.currentUser!;
  List<String> status2 = [
    'Requested',
    'Accepted',
    'Verified',
    'Rejected',
  ];
  bool isPressed = false;
  String selectedStatus = 'Requested';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebase
          .collection("Users")
          .where("uid", isEqualTo: widget.uid)
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
                ? Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        gradient: kmygd,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          widget.work,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                              letterSpacing: 3),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: kc30,
                          backgroundImage: image,
                        ),
                        trailing: IconButton(
                          tooltip: 'Update Status',
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: kc602,
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                builder: (context) => Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Choose Status :',
                                                style: TextStyle(
                                                    color: kc30,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ksize(y: 8),
                                              SizedBox(
                                                width: 200,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      width: 4,
                                                                      color:
                                                                          kblue3))),
                                                  value: selectedStatus,
                                                  items: status2
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
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
                                            kheight,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ksize(y: 85),
                                              Container(
                                                width: 115,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: kc10,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: TextButton(
                                                    onHover: (hovered) =>
                                                        setState(() {
                                                      isPressed = hovered;
                                                    }),
                                                    style: TextButton.styleFrom(
                                                        side: const BorderSide(
                                                            color: Colors.white,
                                                            width: 3),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    onPressed: () {
                                                      // await Future.delayed(const Duration(milliseconds: 800));
                                                      firebase
                                                          .collection("Workers")
                                                          .doc(document['uid'])
                                                          .update({
                                                        'status': selectedStatus
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    onLongPress: () {
                                                      // Navigator.pop(context);
                                                    },
                                                    child: Listener(
                                                      onPointerDown: (event) =>
                                                          setState(() {
                                                        isPressed = true;
                                                      }),
                                                      onPointerUp: (event) =>
                                                          setState(() {
                                                        isPressed = false;
                                                      }),
                                                      child: SizedBox(
                                                        width: 100,
                                                        height: 30,
                                                        child: Center(
                                                          child: Text(
                                                            'Update',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              shadows: [
                                                                for (double i =
                                                                        1;
                                                                    i <
                                                                        (isPressed
                                                                            ? 10
                                                                            : 6);
                                                                    i++)
                                                                  const Shadow(
                                                                    color:
                                                                        kshadowColor,
                                                                    blurRadius:
                                                                        3,
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
                                    ));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => UpdateStatus(),
                            //   ),
                            // );
                          },
                          icon: const Icon(
                            Icons.domain_verification_rounded,
                            size: 50,
                            color: kc10,
                            shadows: kshadow,
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
                        children: [
                          kheight,
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.desc,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: kblue3,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          kheight,
                          Text(
                            'Experience - ${widget.exp}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Phone number - ${document['phone']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                          Text(
                            'From : ${document['place']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                            ),
                          )
                        ],
                      ),
                    ))

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
