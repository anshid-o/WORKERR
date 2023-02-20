// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:workerr_app/core/colors.dart';
// import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/main/chat/widgets/chat_screen2.dart';

// class ViewUser extends StatefulWidget {
//   ImageProvider img;
//   String name;
//   String page;
//   Map<String, dynamic> myPDoc;
//   Map<String, dynamic> myDoc;
//   int index;

//   ViewUser(
//       {super.key,
//       this.page = 'chat',
//       required this.myPDoc,
//       required this.myDoc,
//       required this.name,
//       required this.index,
//       required this.img});
//   bool flag = false;
//   List<String> url = [];
//   List<String> det = [];
//   List<String> pid = [];
//   int count = 0;
//   int likes = 0;

//   @override
//   State<ViewUser> createState() => _ViewUserState();
// }

// class _ViewUserState extends State<ViewUser> {
//   getData() async {
//     final documentReference = FirebaseFirestore.instance
//         .collection("Favorites")
//         .doc('${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');
//     final a = await FirebaseFirestore.instance
//         .collection("Posts")
//         .where('uid', isEqualTo: widget.myDoc['uid'])
//         .orderBy('time', descending: true)
//         .get();
//     final b = await FirebaseFirestore.instance
//         .collection("Favorites")
//         .where('wid', isEqualTo: widget.myDoc['uid'])
//         .get();
//     final c = await FirebaseFirestore.instance.collection("Likes").get();
//     final d = await FirebaseFirestore.instance.collection("Favorites").get();

//     documentReference.get().then((documentSnapshot) {
//       if (documentSnapshot.exists &&
//           mounted &&
//           documentSnapshot.data()!['status'] == true) {
//         setState(() {
//           widget.flag = true;
//         });
//         // The document exists
//         // final data = documentSnapshot.data();

//         // You can now access the values stored in the document
//       }
//     });
//     for (var element in a.docs) {
//       if (mounted) {
//         setState(() {
//           widget.url.add(element['imageUrl']);
//           widget.pid.add(element.id);
//           widget.det.add(element['details']);
//         });
//       }
//     }
//     if (mounted) {
//       for (var alem in a.docs) {
//         for (var element in c.docs) {
//           if (element['itemId'] == alem.id) {
//             setState(() {
//               widget.likes++;
//             });
//           }
//         }
//       }
//       for (var yt in d.docs) {
//         if (yt['status'] == true && yt['wid'] == widget.myDoc['uid']) {
//           setState(() {
//             widget.count++;
//           });
//         }
//       }
//     }
//   }

//   @override
//   void initState() {
//     getData();
//     // TODO: implement initState

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: kc30,
//       appBar: AppBar(
//         backgroundColor: kc30,
//         title: const Text('Profile'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(.1),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(12.0, 8, 12, 5),
//                               child: Hero(
//                                 tag: 'image_${widget.page}${widget.index}',
//                                 child: CircleAvatar(
//                                   radius: size.width * .15,
//                                   backgroundColor: kc30,
//                                   backgroundImage: widget.img,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             widget.name,
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(right: 10, top: 5, bottom: 5),
//                         child: Column(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.myPDoc['job'],
//                               style: const TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                             kheight,
//                             Text(
//                               'Experience : ${widget.myPDoc['experience']}',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Rating : ${widget.myPDoc['rating']}',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Followers : ${widget.count}',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Likes : ${widget.likes}',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             kheight,
//                             SizedBox(
//                               width: size.width * .55,
//                               child: Text(
//                                 '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t${widget.myPDoc['details']}',
//                                 overflow: TextOverflow.visible,
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Email : ${widget.myDoc['email']}',
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         kheight,
//                         Text(
//                           'Phone No : ${widget.myDoc['phone']}',
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         kheight,
//                         Row(
//                           children: [
//                             Text(
//                               widget.myDoc['place'],
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             const Text(
//                               ' , Pin Code : ',
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               widget.myDoc['pin'],
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               ' , at ${widget.myDoc['district']}',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               height: size.height * .08,
//               decoration: BoxDecoration(
//                   color: kc10, borderRadius: BorderRadius.circular(20)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all(
//                             const EdgeInsets.symmetric(
//                                 horizontal: 35, vertical: 10)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                             side: const BorderSide(color: kc30)))),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatScreen2(
//                                 phone: widget.myDoc['phone'],
//                                 name: widget.name,
//                                 img: widget.img,
//                                 id: widget.myDoc['uid']),
//                           ));
//                     },
//                     icon: const Icon(Icons.chat),
//                     label: const Text('Message'),
//                   ),
//                   ElevatedButton.icon(
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all(
//                             const EdgeInsets.symmetric(
//                                 horizontal: 22, vertical: 10)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                             side: const BorderSide(color: kc30)))),
//                     onPressed: () {
//                       final user = FirebaseAuth.instance.currentUser;
//                       final documentReference = FirebaseFirestore.instance
//                           .collection("Favorites")
//                           .doc(
//                               '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');

//                       documentReference.get().then((documentSnapshot) {
//                         if (documentSnapshot.exists) {
//                           // The document exists
//                           final data = documentSnapshot.data();

//                           // You can now access the values stored in the document
//                           if (data!['status'] == true) {
//                             (FirebaseFirestore.instance
//                                 .collection('Favorites')
//                                 .doc(
//                                     '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
//                                 .update({'status': false}));
//                             setState(() {
//                               widget.flag = false;
//                             });
//                           } else {
//                             FirebaseFirestore.instance
//                                 .collection('Favorites')
//                                 .doc(
//                                     '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
//                                 .update({'status': true});
//                             setState(() {
//                               widget.flag = true;
//                             });
//                           }
//                           if (mounted) {
//                             if (widget.flag == false) {
//                               setState(() {
//                                 widget.count--;
//                               });
//                             } else {
//                               setState(() {
//                                 widget.count++;
//                               });
//                             }
//                           }
//                         } else {
//                           FirebaseFirestore.instance
//                               .collection("Favorites")
//                               .doc(
//                                   '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
//                               .set({
//                             'status': true,
//                             'name': widget.myDoc['name'],
//                             'uid': FirebaseAuth.instance.currentUser!.uid,
//                             'wid': widget.myDoc['uid'],
//                             'time': DateTime.now()
//                           });
//                           setState(() {
//                             widget.flag = true;
//                           });
//                         }
//                       });
//                       // if (mounted) {
//                       //   if (widget.flag == true) {
//                       //     setState(() {
//                       //       widget.count--;
//                       //     });
//                       //   } else {
//                       //     setState(() {
//                       //       widget.count++;
//                       //     });
//                       //   }
//                       // }
//                     },
//                     icon: widget.flag
//                         ? const Icon(
//                             CupertinoIcons.heart_solid,
//                             color: kred,
//                             shadows: kshadow,
//                           )
//                         : const Icon(
//                             CupertinoIcons.heart,
//                             color: kred,
//                             shadows: kshadow,
//                           ),
//                     label: const Text('Add to Favourite'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: widget.url.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0),
//               itemBuilder: (BuildContext context, int index) {
//                 return widget.url[index] == ''
//                     ? Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Container(
//                             decoration: BoxDecoration(
//                               color: kc10.withOpacity(.1),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(child: Text(widget.det[index]))),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               widget.url[index],
//                             )),
//                       );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
