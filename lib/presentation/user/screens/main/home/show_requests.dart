import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/home/nav_drawer.dart';

import 'package:workerr_app/presentation/user/screens/my_tabbed_appbar.dart';

import 'package:workerr_app/presentation/user/widgets/work_card2.dart';

class ShowRequest extends StatefulWidget {
  ShowRequest({Key? key}) : super(key: key);

  @override
  State<ShowRequest> createState() => _ShowRequestState();
}

class _ShowRequestState extends State<ShowRequest> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kc30,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            backgroundColor: kc30.withGreen(18),
            // automaticallyImplyLeading: false,
            // leading: IconButton(
            //     onPressed: () {
            //       Scaffold.of(context).openDrawer();
            //     },
            //     icon: Icon(Icons.keyboard_option_key)),
            title: const Text(
              'My requests',
              style: TextStyle(
                  color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                tooltip: 'Top Workers',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyTabbedAppBar(),
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.person_3_fill,
                  color: kc10,
                  size: 30,
                  shadows: kshadow2,
                ),
              ),
              kwidth
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firebase
              .collection("Works")
              .where("uid", isEqualTo: user.uid)
              // .where('status', isNotEqualTo: 'Completed')
              .where('status', whereNotIn: ['Failed', 'Done', 'Completed'])
              .orderBy('status')
              .orderBy('time', descending: true)
              .snapshots(),
          // .where({"status", "is", "Requested"}).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 8),
                            child: Slidable(
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                  extentRatio: .3,
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      autoClose: true,
                                      borderRadius: BorderRadius.circular(15),
                                      onPressed: (context) =>
                                          _onDismissed(document.id),
                                      backgroundColor:
                                          CupertinoColors.destructiveRed,
                                      icon: Icons.delete_forever,
                                      label: 'delete',
                                    ),
                                  ]),
                              startActionPane: ActionPane(
                                extentRatio: .3,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    autoClose: true,
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) =>
                                        _onDone(document.id),
                                    backgroundColor: Colors.green,
                                    icon: Icons.done_all,
                                    label: 'Done',
                                  ),
                                ],
                              ),
                              child: WorkCard2(
                                index: index,
                                myDoc: document,
                              ),
                            ),
                          );
                        },
                      )
                    : Padding(
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
                      );
            }
          },
        ),
      ),
    );
  }

  void _onDone(String id) {
    firebase.collection('Works').doc(id).update({'status': 'Done'});
  }

  void _onDismissed(String id) {
    firebase.collection('Works').doc(id).delete();
  }
}
