import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/widgets/user_details.dart';
import 'package:workerr_app/presentation/user/widgets/view_user.dart';
import 'package:workerr_app/presentation/user/widgets/view_workers.dart';

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
  String name = '';
  String url = '';
  Map<String, dynamic> userPostDoc = {};
  Map<String, dynamic> workerPostDoc = {};

  ImageProvider image = const AssetImage('assets/persons/althaf.jpg');

  getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final documentReference = FirebaseFirestore.instance
        .collection("Likes")
        .doc('${user!.uid}${widget.myDoc.id}');

    documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists && mounted) {
        setState(() {
          isPressed = true;
        });
        // The document exists
        // final data = documentSnapshot.data();

        // You can now access the values stored in the document
      }
    });

    final userData =
        FirebaseFirestore.instance.collection("Users").doc(widget.myDoc['uid']);
    final workerData = FirebaseFirestore.instance
        .collection("Workers")
        .doc(widget.myDoc['uid']);
    userData.get().then((us) {
      if (us.exists && mounted) {
        // The document exists
        final userDoc = us.data();

        // You can now access the values stored in the document

        setState(() {
          name = userDoc!['name'];
          url = userDoc['imageUrl'];
          userPostDoc = userDoc;
          image = url == ''
              ? const AssetImage('assets/persons/default.jpg')
              : NetworkImage(url) as ImageProvider;
        });
      }
    });
    workerData.get().then((us) {
      if (us.exists && mounted) {
        // The document exists
        final userDoc = us.data();

        // You can now access the values stored in the document

        setState(() {
          workerPostDoc = userDoc!;
        });
      }
    });
  }

  void _addLike() async {
    await FirebaseFirestore.instance
        .collection("Likes")
        .doc('${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc.id}')
        .set({
      "itemId": widget.myDoc.id,
      "like": true,
    });
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.myDoc.id)
        .update({'like': FieldValue.increment(1)});
    if (mounted) {
      setState(() {
        isPressed = true;
      });
    }
  }

  void _removeLike() async {
    await FirebaseFirestore.instance
        .collection("Likes")
        .doc('${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc.id}')
        .delete();
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.myDoc.id)
        .update({'like': FieldValue.increment(-1)});
    if (mounted) {
      setState(() {
        isPressed = false;
      });
    }

    // likes.documents.forEach((like) async {
    //   await Firestore.instance.collection("likes").document(like.documentID).delete();
    // });
  }

  @override
  void initState() {
    // TODO: implement initState

    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return ExpansionTile(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetails(
                      page: 'post',
                      name: name,
                      img: image,
                      index: widget.index,
                    ),
                  ));
            },
            child: image == const AssetImage('assets/persons/althaf.jpg')
                ? CircularProgressIndicator()
                : Hero(
                    tag: 'image_post${widget.index}',
                    child: biuldImage(image))),
        initiallyExpanded: true,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewWorkers(
                        page: 'post',
                        name: name,
                        myPDoc: workerPostDoc,
                        myDoc: userPostDoc,
                        img: image,
                        index: widget.index,
                      ),
                    ));
              },
              child: Text(
                name,
                style: const TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  if (isPressed) {
                    // _likes--;
                    _removeLike();
                    isPressed = false;
                  } else {
                    // _likes++;
                    _addLike();
                    isPressed = true;
                  }
                });
                //                               final user =
                //                                   FirebaseAuth.instance.currentUser;
                //                               final documentReference = FirebaseFirestore
                //                                   .instance
                //                                   .collection("Likes")
                //                                   .doc(
                //                                       '${user!.uid}${widget.myDoc.id}');

                //                               documentReference
                //                                   .get()
                //                                   .then((documentSnapshot) {
                //                                 if (documentSnapshot.exists) {
                //                                   // The document exists
                //                                   final data = documentSnapshot.data();

                //                                   // You can now access the values stored in the document
                //                                   if (data!['liked'] == true) {
                //                                     (firebase
                //                                         .collection('Likes')
                //                                         .doc(
                //                                             '${user.uid}${widget.myDoc.id}')
                //                                         .update({'liked': false}));
                //                                     setState(() {
                //                                       isPressed = false;
                //                                     });
                // firebase
                //     .collection('Posts')
                //     .doc(widget.myDoc.id)
                //     .update({
                //   'like': FieldValue.increment(-1)
                // });
                //                                   } else {
                //                                     firebase
                //                                         .collection('Likes')
                //                                         .doc(
                //                                             '${user.uid}${widget.myDoc.id}')
                //                                         .update({'liked': true});
                //                                     setState(() {
                //                                       isPressed = true;
                //                                     });
                //                                     firebase
                //                                         .collection('Posts')
                //                                         .doc(widget.myDoc.id)
                //                                         .update({
                //                                       'like': FieldValue.increment(1)
                //                                     });
                //                                   }
                //                                 } else {
                //                                   firebase
                //                                       .collection("Likes")
                //                                       .doc(
                //                                           '${user.uid}${widget.myDoc.id}')
                //                                       .set({
                //                                     'liked': true,
                //                                     'id': widget.myDoc.id
                //                                   });
                //                                   setState(() {
                //                                     isPressed = true;
                //                                   });
                //                                   firebase
                //                                       .collection('Posts')
                //                                       .doc(widget.myDoc.id)
                //                                       .update({
                //                                     'like': FieldValue.increment(1)
                //                                   });
                //                                 }
                //                               });
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
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${widget.myDoc['like']}',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
        trailing: const SizedBox(
          height: 1,
          width: 1,
        ),
        subtitle: Text(
          widget.myDoc['work'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: kc10),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(widget.size.width * .23, 5, 30, 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.myDoc['details'],
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          widget.myDoc['imageUrl'] != ''
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.myDoc['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      )),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.myDoc['date'],
                  style: TextStyle(
                      color: kc60.withOpacity(.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]);
  }

  biuldImage(ImageProvider img) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: kc60,
      backgroundImage: img,
      // child: url == '' ? CircularProgressIndicator() : null,
    );
  }
}
