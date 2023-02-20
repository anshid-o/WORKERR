import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/search_result.dart';

class SeachPage extends StatefulWidget {
  String id;
  String work;
  SeachPage({super.key, required this.work, required this.id});

  @override
  State<SeachPage> createState() => _SeachPageState();
}

String name = '';
TextEditingController ks = TextEditingController();

class _SeachPageState extends State<SeachPage> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kc30.withOpacity(.75),
        title: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: kc30,
            ),
          ),
          child: TextField(
            controller: ks,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ks.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          ks.text = '';
                          setState(() {
                            name = ks.text;
                          });
                        },
                        icon: const Icon(Icons.close))
                    : null,
                hintText: 'Search..'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Workers')
            .where('job', isEqualTo: widget.work)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          if (name.isEmpty) {
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .where("uid", isEqualTo: data['uid'])
                                  .snapshots(),
                              // .where({"status", "is", "Requested"}).snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center();
                                  default:
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[0];
                                    ImageProvider image =
                                        document['imageUrl'] == ''
                                            ? const AssetImage(
                                                'assets/persons/default.jpg')
                                            : NetworkImage(document['imageUrl'])
                                                as ImageProvider;
                                    return snapshot.data!.docs.isNotEmpty
                                        ? SearchResult(
                                            id: widget.id,
                                            image: image,
                                            data: data,
                                            widget: widget,
                                            document: document)
                                        : Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 100, 30, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: kc60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'You are not posted any works yet.',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: kc30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                }
                              },
                            );
                          }
                          if (data['name']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase())) {
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .where("uid", isEqualTo: data['uid'])
                                  .snapshots(),
                              // .where({"status", "is", "Requested"}).snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center();
                                  default:
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[0];
                                    ImageProvider image =
                                        document['imageUrl'] == ''
                                            ? const AssetImage(
                                                'assets/persons/default.jpg')
                                            : NetworkImage(document['imageUrl'])
                                                as ImageProvider;
                                    return snapshot.data!.docs.isNotEmpty
                                        ? SearchResult(
                                            id: widget.id,
                                            image: image,
                                            data: data,
                                            widget: widget,
                                            document: document)
                                        : Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 100, 30, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: kc60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'You are not posted any works yet.',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: kc30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                }
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: kc30gd),
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(color: kc60, width: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            onLongPress: () {
                              // Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
