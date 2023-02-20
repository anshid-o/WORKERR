// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/screens/search_workers.dart';
import 'package:workerr_app/presentation/user/widgets/animated_list.dart';
// import 'package:workerr_app/presentation/user/widgets/top_list_card.dart';
import 'package:workerr_app/presentation/user/widgets/top_list_card2.dart';

class MyTabbedAppBar extends StatefulWidget {
  const MyTabbedAppBar({Key? key}) : super(key: key);

  @override
  State<MyTabbedAppBar> createState() => _MyTabbedAppBarState();
}

class _MyTabbedAppBarState extends State<MyTabbedAppBar> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: kc30,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  // decoration: TextDecoration.underline,
                  // decorationStyle: TextDecorationStyle.solid,
                  // decorationThickness: 2.5,
                  // decorationColor: Colors.,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/wow.jpg'), fit: BoxFit.cover)
                    // gradient: LinearGradient(colors: [
                    //   Colors.green,
                    //   Colors.red,
                    // ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                    ),
              ),
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
                            Icons.workspace_premium_outlined,
                            color: kgold,
                            size: 20,
                          ),
                          Text(
                            'Top Workers',
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
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          Text(
                            'My Favorites',
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
              stream: firebase
                  .collection("Workers")
                  .orderBy('rating', descending: true)
                  .snapshots(),
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
                                return TopList2(
                                  myDoc: document,
                                  i: index,
                                );
                              },
                              itemCount: snapshot.data!.docs.length < 20
                                  ? snapshot.data!.docs.length
                                  : 20,
                            ),
                            // ListWheelScrollView(
                            //   // controller: controller,
                            //   perspective: 0.003,
                            //   // onSelectedItemChanged: (index) {
                            //   //   showToast('Selected Item : ${index + 1}');
                            //   // },
                            //   squeeze: .95,
                            //   // offAxisFraction: 1.5,
                            //   physics: const FixedExtentScrollPhysics(),
                            //   itemExtent: 450,
                            //   children: [
                            //     CategoryCard(
                            //       i: 0,
                            //       category: 'Mechanic',
                            //     ),
                            //     CategoryCard(
                            //       i: 1,
                            //       category: 'Driver',
                            //     ),
                            //     CategoryCard(
                            //       i: 2,
                            //       category: 'Fabricationer',
                            //     ),
                            //     CategoryCard(
                            //       i: 3,
                            //       category: 'Plumber',
                            //     ),
                            //     CategoryCard(
                            //       i: 4,
                            //       category: 'Painter',
                            //     ),
                            //     CategoryCard(
                            //       i: 5,
                            //       category: 'Electrition',
                            //     ),
                            //   ],
                            // ),
                            MyAnimatedList(
                              myList: snapshot.data!.docs,
                            ),
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

// class CategoryCard extends StatefulWidget {
//   String category;
//   int i;
//   CategoryCard({
//     required this.category,
//     required this.i,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CategoryCard> createState() => _CategoryCardState();
// }

// class _CategoryCardState extends State<CategoryCard> {
//   // List<String> workers = [
//   //   'Anshid O',
//   //   'Yaseen',
//   //   'Hisham',
//   //   'Nijas Ali',
//   //   'Sidheeq',
//   //   'Junaid',
//   //   'Althaf',
//   //   'Adil',
//   //   'Mishal',
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     bool isPressed = false;
//     return Center(
//       child: Container(
//         width: 370,
//         height: 310,
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           gradient: kwhitegd2,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "Best ${widget.category}",
//                   style: const TextStyle(
//                       decoration: TextDecoration.underline,
//                       decorationColor: Colors.black,
//                       color: kc30,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       isPressed = !isPressed;
//                     });
//                   },
//                   child: CircleAvatar(
//                     radius: 20,
//                     child: isPressed
//                         ? const Icon(
//                             Icons.bookmark_added,
//                             color: Colors.red,
//                           )
//                         : const Icon(
//                             Icons.bookmark,
//                             color: Colors.red,
//                           ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: const [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage('assets/abbc.jpg'),
//                     )
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Name : ${workers[widget.i]}',
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     kheight20,
//                     const Text(
//                       'Place : Areakode',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     kheight20,
//                     const Text(
//                       'Rating : 4.8',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
