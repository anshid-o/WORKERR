import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/admin/screens/report/admin_reply.dart';

class ReportCard2 extends StatelessWidget {
  String uid;
  String id;
  String date;
  String report;
  String subject;
  ReportCard2(
      {Key? key,
      required this.date,
      required this.id,
      required this.report,
      required this.subject,
      required this.uid})
      : super(key: key);
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  // final _url =
  //     'https://console.firebase.google.com/project/workerr-ea59b/firestore/data/~2FFeedback~2FS7ZsneY3FhTOsZ4DJlAY';

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kc602,
                        // gradient: kmygd,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          subject,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kc30,
                              letterSpacing: 0),
                        ),
                        subtitle: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kc302,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: image,
                        ),
                        // trailing: const CircleAvatar(
                        //   radius: 16,
                        //   backgroundColor: kc10,
                        //   child: Icon(CupertinoIcons.)
                        // ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 18, 18, 5),
                            child: Text(
                              report,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '- ${document['name']}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              kwidth20,
                              kwidth30
                            ],
                          ),
                          kheight20,
                          // kheight30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kc30),
                                    // elevation: MaterialStateProperty.all(4.0),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AdminReply(
                                            uid: uid,
                                            id: id,
                                            subject: subject,
                                          ),
                                        ));
                                  },
                                  child: const Text(
                                    'Give Reply',
                                    style: TextStyle(
                                        color: kc10,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kc30),
                                  // elevation: MaterialStateProperty.all(4.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  // final url =
                                  //     'https://console.firebase.google.com/project/workerr-ea59b/firestore/data/~2FFeedback~2FS7ZsneY3FhTOsZ4DJlAY';
                                  final ux = Uri(
                                      scheme: 'https',
                                      host: 'console.firebase.google.com',
                                      path:
                                          'project/workerr-ea59b/firestore/data');
                                  if (await canLaunchUrl(ux)) {
                                    await launchUrl(ux,
                                        mode: LaunchMode.inAppWebView);
                                  }
                                  // if (await canLaunch(url)) {
                                  //   await launch(url,
                                  //       forceWebView: true,
                                  //       enableJavaScript: true);
                                  // }
                                },
                                child: const Text(
                                  'Take Action',
                                  style: TextStyle(
                                      color: kc10,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          kheight
                        ],
                      ),
                    ),
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

  // void _launchURL() async => await canLaunch(_url)
  //     ? await launch(_url)
  //     : throw 'Could not launch $_url';
}
