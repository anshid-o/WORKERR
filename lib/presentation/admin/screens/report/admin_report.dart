import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
// import 'package:workerr_app/presentation/admin/widgets/report_card.dart';
import 'package:workerr_app/presentation/admin/widgets/report_card2.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';

class AdminReportScreen extends StatelessWidget {
  AdminReportScreen({Key? key}) : super(key: key);
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
            automaticallyImplyLeading: false,
            title: const Text(
              'Reports',
              style: TextStyle(
                  color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firebase
              .collection("Reports")
              .where("status", isEqualTo: 'Reported')
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
                          // var name;
                          // final docUser = firebase
                          //     .collection('Users')
                          //     .doc(document['uid'])
                          //     .get();
                          // docUser.then((value) => print(value['name']));

                          return ReportCard2(
                              date: document['date'],
                              id: document.id,
                              report: document['details'],
                              subject: document['subject'],
                              uid: document['uid']);
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
                              'There are No waiting workers.',
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

        //  ListView.builder(
        //   itemBuilder: ((context, index) => const ReportCard2()),
        //   itemCount: 10,
        // ),
      ),
    );
  }
}
