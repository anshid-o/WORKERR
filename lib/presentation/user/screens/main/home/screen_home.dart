import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/home/nav_drawer.dart';

import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';
import 'package:workerr_app/presentation/user/widgets/post_card.dart';

import 'package:workerr_app/presentation/user/widgets/work_card2.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: MyNavigationDrawer(),
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
              'Workerr',
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
              .collection("Posts")
              .orderBy('time', descending: true)
              // .where('status', isNotEqualTo: 'Completed')
              // .where('status', isNotEqualTo: 'Failed')
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kc602,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PostCard(
                                    isHome: true,
                                    size: size,
                                    id: document.id,
                                    like: document['like'],
                                    date: document['date'],
                                    details: document['details'],
                                    uid: document['uid'],
                                    work: document['work'],
                                    url: document['imageUrl'],
                                  ),
                                ],
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
}
