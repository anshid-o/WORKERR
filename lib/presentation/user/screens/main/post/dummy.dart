import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workerr_app/presentation/user/screens/main/post/tempw.dart';

class RequestedPage extends StatefulWidget {
  const RequestedPage({Key? key}) : super(key: key);

  @override
  State<RequestedPage> createState() => _RequestedPageState();
}

class _RequestedPageState extends State<RequestedPage> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Works of current user"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebase
            .collection("Works")
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        // .where({"status", "is", "Requested"}).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return WorkCard2(
                    index: index,
                    date: document['date'],
                    work: document['work'],
                    details: document['details'],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
