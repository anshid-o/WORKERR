import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

class BuildList extends StatelessWidget {
  String uid;
  double rating;
  String name;
  String work;
  String id;
  int count;
  String exp;
  String det;
  // String pin;
  bool isdec;
  BuildList(
      {Key? key,
      required this.rating,
      required this.count,
      required this.name,
      required this.id,
      required this.det,
      required this.isdec,
      required this.exp,
      required this.uid,
      required this.work})
      : super(key: key);

  // IconData icon = Icons.send_outlined;
  final storeUser = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // itemCount: workers.length,
    // itemBuilder: ((context, index) {
    // final sortedItems = isDescending ? workers.reversed.toList() : workers;
    // final sortedItems = workers
    //   ..sort((item1, item2) =>
    //       isDescending ? item2.compareTo(item1) : item1.compareTo(item2));
    // final item = sortedItems[index];
    return StreamBuilder<QuerySnapshot>(
      stream:
          firebase.collection("Users").where("uid", isEqualTo: uid).snapshots(),
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
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: kc602),
                      child: ExpansionTile(
                        //  tileColor: Colors.amber,
                        // selectedTileColor: Colors.green,
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: image,
                              radius: 28,
                              backgroundColor: kblue3,
                              // child: Icon(
                              //   Icons.person,
                              //   size: 50,
                              // ),
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Text(document['name']),
                            kwidth20,
                          ],
                        ),
                        subtitle: Text('${exp} years of Experience'),
                        trailing: IconButton(
                          splashColor: kc10,
                          tooltip: 'Send Request',
                          // focusColor: kred,
                          // hoverColor: kred,
                          onPressed: (() {
                            final now = DateTime.now();
                            String formatter = DateFormat('yMd').format(now);
                            // print('user not null');

                            // .where("field", "==", certainValue)
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              storeUser.collection("Requests").doc().set({
                                'from': user.uid,
                                'job': work,
                                'to': uid,
                                'rating': rating,
                                'count': count,
                                'toName': name,
                                'id': id,
                                'details': det,
                                'status': 'Requested',
                                'date': formatter,
                                'time': now
                              });
                            }
                            // setState(() {
                            //   icon = Icons.done;
                            // });
                            showDone(
                                context,
                                'Request sent to ${document['name']}',
                                CupertinoIcons.envelope,
                                Colors.green);
                          }),
                          icon: const Icon(
                            Icons.send_outlined,
                            color: kc10,
                          ),
                        ),
                        children: [
                          Text(
                            document['pin'],
                            style: TextStyle(color: kblue3),
                          ),
                          kheight,
                          Text(
                            'Rating : 4.2',
                            style: TextStyle(color: kblue3),
                          ),
                          kheight,
                          Text(
                            det,
                            style: const TextStyle(color: kblue3),
                          ),
                        ],
                      ),
                    ),
                  )

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
