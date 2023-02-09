import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';
import 'package:workerr_app/presentation/user/widgets/request_card.dart';
import 'package:workerr_app/presentation/user/widgets/request_card2.dart';

class ScreenRequest extends StatelessWidget {
  ScreenRequest({Key? key}) : super(key: key);
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kc30,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            backgroundColor: kc30.withGreen(18),
            automaticallyImplyLeading: false,
            title: const Text(
              'Requests',
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
              .collection("Requests")
              .where("to", isEqualTo: user!.uid)
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
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          return RequestCard2(
                              id: document.id,
                              status: document['status'],
                              date: document['date'],
                              work: document['job'],
                              det: document['details'],
                              from: document['from'],
                              uid: document['to']);
                        },
                        itemCount: snapshot.data!.docs.length,
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
                              'There are doesn\'t found any requests.',
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
