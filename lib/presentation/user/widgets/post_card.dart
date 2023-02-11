import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/widgets/user_details.dart';

class PostCard extends StatefulWidget {
  // String date;
  // String id;
  // String url;
  // int like;
  int index;
  DocumentSnapshot myDoc;
  bool isHome;
  // String work;
  // String uid;
  // String details;
  PostCard(
      {super.key,
      // this.id = '',
      // this.like = 0,
      required this.index,
      this.isHome = false,
      required this.size,
      required this.myDoc
      // required this.date,
      // required this.details,
      // required this.uid,
      // required this.work,
      // required this.url

      });

  final Size size;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final storeUser = FirebaseFirestore.instance;

  bool isPressed = false;
  @override
  void initState() {
    // TODO: implement initState
    final user = FirebaseAuth.instance.currentUser;
    final documentReference = FirebaseFirestore.instance
        .collection("Likes")
        .doc('${user!.uid}${widget.myDoc.id}');

    documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        // The document exists
        final data = documentSnapshot.data();

        // You can now access the values stored in the document
        if (data!['liked'] == true) {
          setState(() {
            isPressed = true;
          });
        } else {
          setState(() {
            isPressed = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: storeUser
          .collection("Users")
          .where('uid', isEqualTo: widget.myDoc['uid'])
          .snapshots(),
      // .where({"status", "is", "Requested"}).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center();
          default:
            DocumentSnapshot document = snapshot.data!.docs[0];
            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? ExpansionTile(
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetails(
                                  page: 'post',
                                  name: document['name'],
                                  img: image,
                                  index: widget.index,
                                ),
                              ));
                        },
                        child: Hero(
                            tag: 'image_post${widget.index}',
                            child: biuldImage(image))),
                    initiallyExpanded: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          document['name'],
                          style: const TextStyle(
                              color: kc30,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        if (widget.isHome)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  final documentReference = FirebaseFirestore
                                      .instance
                                      .collection("Likes")
                                      .doc('${user!.uid}${widget.myDoc.id}');

                                  documentReference
                                      .get()
                                      .then((documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      // The document exists
                                      final data = documentSnapshot.data();

                                      // You can now access the values stored in the document
                                      if (data!['liked'] == true) {
                                        (firebase
                                            .collection('Likes')
                                            .doc(
                                                '${user.uid}${widget.myDoc.id}')
                                            .update({'liked': false}));
                                        setState(() {
                                          isPressed = false;
                                        });
                                        firebase
                                            .collection('Posts')
                                            .doc(widget.myDoc.id)
                                            .update({
                                          'like': FieldValue.increment(-1)
                                        });
                                      } else {
                                        firebase
                                            .collection('Likes')
                                            .doc(
                                                '${user.uid}${widget.myDoc.id}')
                                            .update({'liked': true});
                                        setState(() {
                                          isPressed = true;
                                        });
                                        firebase
                                            .collection('Posts')
                                            .doc(widget.myDoc.id)
                                            .update({
                                          'like': FieldValue.increment(1)
                                        });
                                      }
                                    } else {
                                      firebase
                                          .collection("Likes")
                                          .doc('${user.uid}${widget.myDoc.id}')
                                          .set({
                                        'liked': true,
                                        'id': widget.myDoc.id
                                      });
                                      setState(() {
                                        isPressed = true;
                                      });
                                      firebase
                                          .collection('Posts')
                                          .doc(widget.myDoc.id)
                                          .update({
                                        'like': FieldValue.increment(1)
                                      });
                                    }
                                  });
                                },
                                icon: isPressed
                                    ? const Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.grey,
                                      ),
                              ),
                              isPressed
                                  ? Text(
                                      '${widget.myDoc['like']}',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      '${widget.myDoc['like']}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    )
                            ],
                          ),
                      ],
                    ),
                    subtitle: Text(
                      widget.myDoc['work'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.myDoc['details'],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: kc30,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      widget.myDoc['imageUrl'] != ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Image.network(
                                    widget.myDoc['imageUrl'],
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.myDoc['date'],
                            style: TextStyle(
                                color: kc30.withOpacity(.5),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kc60, borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Users not posted any works yet.',
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

  biuldImage(ImageProvider img) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: kc30,
      backgroundImage: img,
    );
  }
}
