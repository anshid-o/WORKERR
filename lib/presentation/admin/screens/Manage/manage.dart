import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/search_workers.dart';
import 'package:workerr_app/presentation/user/widgets/animated_list.dart';
import 'package:workerr_app/presentation/user/widgets/top_list_card2.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: kc30,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Manage Users',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              // flexibleSpace: Container(
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('assets/wow.jpg'), fit: BoxFit.cover)
              //       // gradient: LinearGradient(colors: [
              //       //   Colors.green,
              //       //   Colors.red,
              //       // ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              //       ),
              // ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchWorkersPage(),
                          ));
                      // showSearch(
                      //     context: context, delegate: CustomSeachDeligate());
                    },
                    icon: const Icon(Icons.search))
              ],
              bottom: TabBar(tabs: [
                Tab(
                  // icon: Icon(
                  //   Icons.workspace_premium_sharp,s
                  //   size: 20,
                  // ),
                  // text: 'Top Workers',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.people_alt,
                            color: kc602,
                            size: 20,
                          ),
                          Text(
                            '  Users',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.work,
                            color: kc602,
                            size: 20,
                          ),
                          Text(
                            '  Workers',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: firebase.collection("Users").orderBy('name').snapshots(),
              // .where({"status", "is", "Requested"}).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        ? TabBarView(children: [
                            ListView.builder(
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                return document['uid'] !=
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? TempCard2(document: document)
                                    : Center();
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                            TempCard3()
                          ])
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
            )),
      ),
    );
  }
}

class TempCard2 extends StatelessWidget {
  const TempCard2({
    super.key,
    required this.document,
  });

  final DocumentSnapshot<Object?> document;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        color: kc60,
        child: ExpansionTile(title: Text(document['name'])),
      ),
    );
  }
}

class TempCard3 extends StatelessWidget {
  TempCard3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Workers")
          .orderBy('name')
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
            return snapshot.data!.docs.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          color: kc60,
                          child: ExpansionTile(title: Text(document['name'])),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  )
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

class TabBarRow extends StatelessWidget {
  String name;
  IconData icon;
  Color color;

  TabBarRow({
    Key? key,
    required this.name,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          ksize(y: 3.5),
          Text(name),
        ],
      ),
    );
  }
}
