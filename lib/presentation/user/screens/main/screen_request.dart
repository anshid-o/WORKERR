import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/screens/my_tabbed_appbar.dart';
import 'package:workerr_app/presentation/user/widgets/request_card.dart';
import 'package:workerr_app/presentation/user/widgets/request_card2.dart';

class ScreenRequest extends StatefulWidget {
  ScreenRequest({Key? key}) : super(key: key);
  int count = -1;
  @override
  State<ScreenRequest> createState() => _ScreenRequestState();
}

class _ScreenRequestState extends State<ScreenRequest> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  getData() async {
    final a = await FirebaseFirestore.instance.collection("Workers").get();
    if (mounted) {
      for (var element in a.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          setState(() {
            widget.count = 1;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        body: widget.count == 1
            ? StreamBuilder<QuerySnapshot>(
                stream: firebase
                    .collection("Requests")
                    .where("to", isEqualTo: user!.uid)
                    .where('status', isEqualTo: 'Requested')
                    .snapshots(),
                // .where({"status", "is", "Requested"}).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
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
                                  myDoc: document,
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                        'assets/lottie/not-found.json'),
                                    Container(
                                      height: size.height * .15,
                                      decoration: BoxDecoration(
                                          color: kc60,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'No requests found in your inbox, yet !',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: kc30,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                  }
                },
              )
            : Column(
                children: [
                  Center(
                      child: Lottie.asset('assets/lottie/safety.json',
                          repeat: false)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: size.height * .15,
                      decoration: BoxDecoration(
                          color: kc60, borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Only verified workers get requests !',
                            style: TextStyle(
                                fontSize: 28,
                                color: kc30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
