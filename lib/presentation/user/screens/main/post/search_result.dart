import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/search.dart';

class SearchResult extends StatefulWidget {
  SearchResult({
    super.key,
    required this.image,
    required this.data,
    required this.id,
    required this.widget,
    required this.document,
  });
  String id;
  final ImageProvider<Object> image;
  final Map<String, dynamic> data;
  final SeachPage widget;
  final DocumentSnapshot<Object?> document;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool pressed = false;
  void initState() {
    // TODO: implement initState
    final user = FirebaseAuth.instance.currentUser;
    final documentReference = FirebaseFirestore.instance
        .collection("Requests")
        .doc('${widget.id}${widget.data['uid']}');

    documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          pressed = true;
        });
      } else {
        setState(() {
          pressed = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      //  tileColor: Colors.amber,
      // selectedTileColor: Colors.green,
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundImage: widget.image,
            radius: 28,
            backgroundColor: kblue3,
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
          Text(widget.data['name']),
          const Spacer(),
          Text('⭐ ${widget.data['rating']}'),
        ],
      ),
      subtitle: Text('${widget.data['experience']} years of Experience'),
      trailing: pressed
          ? Icon(Icons.done_rounded)
          : IconButton(
              splashColor: kc10,
              tooltip: 'Send Request',
              // focusColor: kred,
              // hoverColor: kred,
              onPressed: (() {
                setState(() {
                  pressed = true;
                });
                final now = DateTime.now();
                String formatter = DateFormat('yMd').format(now);
                // print('user not null');

                // .where("field", "==", certainValue)
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  FirebaseFirestore.instance.collection("Requests").doc().set({
                    'from': user.uid,
                    'job': widget.data['job'],
                    'to': widget.data['uid'],
                    'rating': widget.data['rating'],
                    'count': widget.data['count'],
                    'toName': widget.data['name'],
                    'id': widget.widget.id,
                    'details': widget.data['details'],
                    'status': 'Requested',
                    'date': formatter,
                    'time': now
                  });
                }
                // setState(() {
                //   icon = Icons.done;
                // });
                showDone(context, 'Request sent to ${widget.data['name']}',
                    CupertinoIcons.envelope, Colors.green);
              }),
              icon: const Icon(
                Icons.send_outlined,
                color: kc10,
              ),
            ),
      children: [
        Text(
          widget.document['pin'],
          style: TextStyle(color: kblue3),
        ),
        kheight,
        Text(
          'Rating : ${widget.data['rating']}',
          style: TextStyle(color: kblue3),
        ),
        kheight,
        Text(
          widget.data['details'],
          style: const TextStyle(color: kblue3),
        ),
      ],
    );
  }
}
