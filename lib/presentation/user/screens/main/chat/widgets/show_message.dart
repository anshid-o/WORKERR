import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';

class ShowMessages extends StatelessWidget {
  const ShowMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: FirebaseFirestore.instance.collection('Messages').oderdBy("time").snapshots(),
        builder: ((context, snapshot) {
      // if (!snapshot.hasData) {
      //   return Center(child: CircularProgressIndicator());
      // }
      return ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: sentMessages.length,
        reverse: false,
        // itemCount: snapshot.data!.docs.length,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, i) {
          // QueryDocumentSnaapshot x = snapshot.data!.docs[i];
          return ListTile(
            title: Column(
              crossAxisAlignment: i % 2 == 0
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              // crossAxisAlignment: loginUser!.email ==x['user'] ?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft: i % 2 == 0
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                          bottomRight: i % 2 == 0
                              ? const Radius.circular(0)
                              : const Radius.circular(15),
                        ),
                        color: i % 2 == 0 ? Colors.blueAccent : kc60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   'Person $i',
                        //   style: const TextStyle(
                        //       fontSize: 13, fontWeight: FontWeight.bold),
                        // ),

                        Text(
                          sentMessages[i],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        kheight,
                        Text(
                          '${i + 1}:00',
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            // title: Text(x['messages']),
          );
        },
      );
    }));
  }
}
