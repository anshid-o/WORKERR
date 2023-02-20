// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class StudentDashBoard extends StatefulWidget {
//   StudentDashBoard({super.key});

//   @override
//   State<StudentDashBoard> createState() => _StudentDashBoardState();
// }

// class _StudentDashBoardState extends State<StudentDashBoard> {
//   String bc = 'Loading';
//   String bac = 'Loading';
//   String rc = 'Loading';
//   String cc = 'Loading';
//   String rd = 'Loading';
//   String sid = '0';
//   Map<String, int> GenreMap = {};
//   Map<String, int> AuthorMap = {};
//   Map<String, int> GenreAllMap = {};
//   Map<String, int> AuthorAllMap = {};
//   List<String> popularGenre = [];
//   List<String> popularAuthor = [];

//   getSuggession() async {
//     var s = await FirebaseFirestore.instance
//         .collection('Issues')
//         .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     var x = s.docs.length;
//     if (x > 0) {
//       for (var element in s.docs) {
//         var flag = 0;
//         if (!GenreMap.containsKey(element['genre'])) {
//           flag++;
//           GenreMap.addAll({element['genre']: flag});
//         } else {
//           flag++;
//           GenreMap.update(element['genre'], (value) => flag);
//         }
//       }
//       for (int i = 0; i < (x > 3 ? 3 : x); i++) {
//         int x = 0;
//         List<String> genre = [];
//         GenreMap.forEach((key, value) {
//           if (x > value) {
//             genre[i] = key;
//           }
//         });
//         setState(() {
//           popularGenre.addAll(genre);
//         });
//       }
//       for (var element in s.docs) {
//         var flag = 0;
//         if (!AuthorMap.containsKey(element['author'])) {
//           flag++;
//           AuthorMap.addAll({element['author']: flag});
//         } else {
//           flag++;
//           AuthorMap.update(element['author'], (value) => flag);
//         }
//       }
//       for (int i = 0; i < (x > 3 ? 3 : x); i++) {
//         int x = 0;
//         List<String> author = [];
//         AuthorMap.forEach((key, value) {
//           if (x > value) {
//             author[i] = key;
//           }
//         });
//         setState(() {
//           popularAuthor.addAll(author);
//         });
//       }
//     }
//     var sa = await FirebaseFirestore.instance.collection('Issues').get();
//     var xa = s.docs.length;
//     if (xa > 0) {
//       s.docs.forEach((element) {
//         var flag = 0;
//         if (!GenreAllMap.containsKey(element['genre'])) {
//           flag++;
//           GenreAllMap.addAll({element['genre']: flag});
//         } else {
//           flag++;
//           GenreAllMap.update(element['genre'], (value) => flag);
//         }
//       });
//       for (int i = 0; i < (x > 3 ? 3 : x); i++) {
//         int x = 0;
//         List<String> genre = [];
//         GenreAllMap.forEach((key, value) {
//           if (x > value) {
//             genre[i] = key;
//           }
//         });
//         setState(() {
//           popularGenre.addAll(genre);
//         });
//       }
//       s.docs.forEach((element) {
//         var flag = 0;
//         if (!AuthorAllMap.containsKey(element['author'])) {
//           flag++;
//           AuthorAllMap.addAll({element['author']: flag});
//         } else {
//           flag++;
//           AuthorAllMap.update(element['author'], (value) => flag);
//         }
//       });
//       for (int i = 0; i < (x > 3 ? 3 : x); i++) {
//         int x = 0;
//         List<String> author = [];
//         AuthorAllMap.forEach((key, value) {
//           if (x > value) {
//             author[i] = key;
//           }
//         });
//         setState(() {
//           popularAuthor.addAll(author);
//         });
//       }
//     }
//     Random rand = Random();
//     int authNum = rand.nextInt(popularAuthor.length);
//     int genNum = rand.nextInt(popularGenre.length);
//     var myBooks = await FirebaseFirestore.instance
//         .collection('Books')
//         .where('genre', isEqualTo: popularGenre[genNum])
//         .where('author', isEqualTo: popularAuthor[authNum])
//         .orderBy('rating', descending: true)
//         .get();
//     print(myBooks.docs[0]['title']);
//   }

//   getData() async {
//     var a = await FirebaseFirestore.instance.collection('Books').get();
//     var s = await FirebaseFirestore.instance
//         .collection('Books')
//         .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     var b = await FirebaseFirestore.instance
//         .collection('Books')
//         .where('status', isEqualTo: 'Available')
//         .get();
//     var c = await FirebaseFirestore.instance.collection('Requests').get();
//     var d = await FirebaseFirestore.instance.collection('Complaints').get();
//     var f = await FirebaseFirestore.instance.collection('Users').get();

//     setState(() {
//       sid = s.docs.length.toString();
//       bc = a.docs.length.toString();
//       bac = b.docs.length.toString();
//       rc = c.docs.length.toString();
//       cc = d.docs.length.toString();
//       rd = f.docs.length.toString();
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return bc == 'Loading'
//         ? Center(child: CircularProgressIndicator())
//         : Column(
//             children: [
//               Container(
//                 //   margin: const EdgeInsets.only(top: 20),
//                 decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.centerRight,
//                         end: Alignment.bottomLeft,
//                         colors: [
//                       Colors.white,
//                       Colors.white,
//                     ])),
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0)),
//                             margin: const EdgeInsets.only(
//                                 left: 20.0, top: 3.0, right: 5.0),
//                             elevation: 26.0,
//                             shadowColor: Colors.white,
//                             color: Colors.blueGrey,
//                             child: Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 30),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.library_books_outlined,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         bc,
//                                         style: const TextStyle(
//                                             fontSize: 20, color: Colors.white),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Text(
//                                         'Total Books',
//                                         style: TextStyle(
//                                             color: Colors.white70,
//                                             fontSize: 12),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0)),
//                             margin: const EdgeInsets.only(
//                                 left: 5, right: 20.0, top: 3.0),
//                             elevation: 26.0,
//                             shadowColor: Colors.white,
//                             color: Colors.blueGrey,
//                             child: Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 30),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.library_books_outlined,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         bac,
//                                         style: const TextStyle(
//                                             fontSize: 20, color: Colors.white),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Text(
//                                         'Available',
//                                         style: TextStyle(
//                                             color: Colors.white70,
//                                             fontSize: 12),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0)),
//                             margin: const EdgeInsets.only(
//                                 left: 20.0, top: 3.0, right: 5.0),
//                             elevation: 26.0,
//                             shadowColor: Colors.white,
//                             color: Colors.blueGrey,
//                             child: Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 30),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.book,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         sid,
//                                         style: const TextStyle(
//                                             fontSize: 20, color: Colors.white),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Text(
//                                         'Books Read',
//                                         style: TextStyle(
//                                             color: Colors.white70,
//                                             fontSize: 12),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0)),
//                             margin: const EdgeInsets.only(
//                                 left: 5, right: 20.0, top: 3.0),
//                             elevation: 26.0,
//                             shadowColor: Colors.white,
//                             color: Colors.blueGrey,
//                             child: Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 30),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.people_alt,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         rd,
//                                         style: const TextStyle(
//                                             fontSize: 20, color: Colors.white),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Text(
//                                         'Readers',
//                                         style: TextStyle(
//                                             color: Colors.white70,
//                                             fontSize: 12),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//   }
// }
