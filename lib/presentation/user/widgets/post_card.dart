import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

class PostCard extends StatefulWidget {
  String date;
  String id;
  String url;
  int like;
  bool isHome;
  String work;
  String uid;
  String details;
  PostCard(
      {super.key,
      this.id = '',
      this.like = 0,
      this.isHome = false,
      required this.size,
      required this.date,
      required this.details,
      required this.uid,
      required this.work,
      required this.url});

  final Size size;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final storeUser = FirebaseFirestore.instance;

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: storeUser
          .collection("Users")
          .where('uid', isEqualTo: widget.uid)
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
                    leading: CircleAvatar(
                      radius: widget.size.width * .08,
                      backgroundColor: kc30,
                      backgroundImage: image,
                    ),
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
                          IconButton(
                              onPressed: () {
                                firebase
                                    .collection('Posts')
                                    .doc(widget.id)
                                    .update({'like': widget.like + 1});
                                setState(() {
                                  isPressed = !isPressed;
                                });
                                isPressed
                                    ? firebase
                                        .collection('Posts')
                                        .doc(widget.id)
                                        .update({'like': widget.like + 1})
                                    : firebase
                                        .collection('Posts')
                                        .doc(widget.id)
                                        .update({'like': widget.like - 1});
                              },
                              icon: isPressed
                                  ? const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.grey,
                                    ))
                      ],
                    ),
                    subtitle: Text(
                      widget.work,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.details,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: kc30,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      widget.url != ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Image.network(
                                    widget.url,
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
                            widget.date,
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
