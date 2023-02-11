import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

// import 'package:workerr_app/presentation/user/widgets/chat_card.dart';
import 'package:workerr_app/presentation/user/widgets/chat_card2.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';

class ScreenChat extends StatelessWidget {
  ScreenChat({Key? key}) : super(key: key);

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

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
              'Messages',
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
              .collection("Messages")
              .where("to", isEqualTo: user!.uid)
              // .where('from')
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
                List<String> froms = [];
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  DocumentSnapshot document = snapshot.data!.docs[i];
                  if (!froms.contains(document['from'])) {
                    froms.add(document['from']);
                  }
                }
                return snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ChatCard2(uid: froms[index], index: index);
                          // return RequestCard2(
                          //     date: document['date'],
                          //     work: document['job'],
                          //     det: document['details'],
                          //     from: document['from'],
                          //     uid: document['to']);
                        },
                        itemCount: froms.length,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Column(
                            children: [
                              Lottie.asset('assets/lottie/not-found.json'),
                              Container(
                                height: size.height * .15,
                                decoration: BoxDecoration(
                                    color: kc60,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'No messsages found in your inbox, yet !',
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
        ),

        //  ListView.builder(
        //   itemBuilder: ((context, index) =>
        //       ChatCard2(name: workers[index], index: index)),
        //   itemCount: workers.length,
        // ),
      ),
    );
  }
}
