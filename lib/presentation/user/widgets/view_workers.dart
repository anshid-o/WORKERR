import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/widgets/chat_screen2.dart';

class ViewWorkers extends StatefulWidget {
  ImageProvider img;
  String name;
  String page;
  Map<String, dynamic> myPDoc;
  Map<String, dynamic> myDoc;
  int index;
  int slected = 0;

  ViewWorkers(
      {super.key,
      this.page = 'chat',
      required this.myPDoc,
      required this.myDoc,
      required this.name,
      required this.index,
      required this.img});
  bool flag = false;
  List<String> url = [];
  List<String> dates = [];
  List<String> dates2 = [];
  List<int> likesList = [];
  List<String> det = [];
  List<String> pid = [];
  int count = 0;
  int likes = 0;

  @override
  State<ViewWorkers> createState() => _ViewWorkersState();
}

class _ViewWorkersState extends State<ViewWorkers> {
  getData() async {
    final documentReference = FirebaseFirestore.instance
        .collection("Favorites")
        .doc('${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');
    final a = await FirebaseFirestore.instance
        .collection("Posts")
        .where('uid', isEqualTo: widget.myDoc['uid'])
        .orderBy('time', descending: true)
        .get();
    final b = await FirebaseFirestore.instance
        .collection("Favorites")
        .where('wid', isEqualTo: widget.myDoc['uid'])
        .get();
    final c = await FirebaseFirestore.instance.collection("Likes").get();
    final d = await FirebaseFirestore.instance.collection("Favorites").get();

    documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists &&
          mounted &&
          documentSnapshot.data()!['status'] == true) {
        setState(() {
          widget.flag = true;
        });
        // The document exists
        // final data = documentSnapshot.data();

        // You can now access the values stored in the document
      }
    });
    for (var element in a.docs) {
      if (mounted) {
        setState(() {
          if (element['imageUrl'] != '') {
            widget.url.add(element['imageUrl']);
            widget.likesList.add(element['like']);
            widget.dates.add(element['date']);
          }
          widget.pid.add(element.id);
          widget.dates2.add(element['date']);
          widget.det.add(element['details']);
        });
      }
    }
    if (mounted) {
      for (var alem in a.docs) {
        for (var element in c.docs) {
          if (element['itemId'] == alem.id) {
            setState(() {
              widget.likes++;
            });
          }
        }
      }
      for (var yt in d.docs) {
        if (yt['status'] == true && yt['wid'] == widget.myDoc['uid']) {
          setState(() {
            widget.count++;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kc60,
      appBar: AppBar(
        backgroundColor: kc30,
        title: Text(
          '${widget.name}\'s Profile',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * .28,
              ),
              Container(
                height: size.height * .16,
                decoration: BoxDecoration(
                  color: kc30.withOpacity(.5),
                  image: DecorationImage(
                      image: widget.img,
                      fit: BoxFit.fitWidth,
                      opacity: .3,
                      colorFilter: ColorFilter.mode(
                          kc10.withOpacity(.25), BlendMode.colorDodge)),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * .07,
                left: size.width * .18,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${widget.count}',
                          style: const TextStyle(
                              color: kblue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(
                              color: kblue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    kwidth,
                    Column(
                      children: [
                        kheight20,
                        Hero(
                          tag: 'image_${widget.page}${widget.index}',
                          child: CircleAvatar(
                            radius: size.width * .15,
                            backgroundColor: kc30,
                            backgroundImage: widget.img,
                          ),
                        ),
                        ksize(x: 10),
                      ],
                    ),
                    kwidth,
                    Column(
                      children: [
                        Text(
                          '${widget.likes}',
                          style: const TextStyle(
                              color: kblue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Likes',
                          style: TextStyle(
                              color: kblue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .27,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: kblue,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    color: kc60,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ksize(x: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.myDoc['place'],
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' , ${widget.myDoc['district']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kblue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 5)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: kc30)))),
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  final documentReference = FirebaseFirestore.instance
                      .collection("Favorites")
                      .doc(
                          '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}');

                  documentReference.get().then((documentSnapshot) {
                    if (documentSnapshot.exists) {
                      // The document exists
                      final data = documentSnapshot.data();

                      // You can now access the values stored in the document
                      if (data!['status'] == true) {
                        (FirebaseFirestore.instance
                            .collection('Favorites')
                            .doc(
                                '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                            .update({'status': false}));
                        setState(() {
                          widget.flag = false;
                        });
                      } else {
                        FirebaseFirestore.instance
                            .collection('Favorites')
                            .doc(
                                '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                            .update({'status': true});
                        setState(() {
                          widget.flag = true;
                        });
                      }
                      if (mounted) {
                        if (widget.flag == false) {
                          setState(() {
                            widget.count--;
                          });
                        } else {
                          setState(() {
                            widget.count++;
                          });
                        }
                      }
                    } else {
                      FirebaseFirestore.instance
                          .collection("Favorites")
                          .doc(
                              '${FirebaseAuth.instance.currentUser!.uid}${widget.myDoc['uid']}')
                          .set({
                        'status': true,
                        'name': widget.myDoc['name'],
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'wid': widget.myDoc['uid'],
                        'time': DateTime.now()
                      });
                      setState(() {
                        widget.flag = true;
                      });
                    }
                  });
                  // if (mounted) {
                  //   if (widget.flag == true) {
                  //     setState(() {
                  //       widget.count--;
                  //     });
                  //   } else {
                  //     setState(() {
                  //       widget.count++;
                  //     });
                  //   }
                  // }
                },
                icon: widget.flag
                    ? const Icon(
                        CupertinoIcons.heart_solid,
                        color: kred,
                        shadows: kshadow,
                      )
                    : const Icon(
                        CupertinoIcons.heart,
                        color: kred,
                        shadows: kshadow,
                      ),
                label: const Text('Add to Favourite'),
              ),
              kwidth,
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kblue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 11)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: kc30)))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen2(
                            phone: widget.myDoc['phone'],
                            name: widget.name,
                            img: widget.img,
                            id: widget.myDoc['uid']),
                      ));
                },
                // icon: const Icon(Icons.chat),
                child: const Text('Message'),
              ),
            ],
          ),
          kheight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.slected = 0;
                    });
                  }
                },
                child: Text(
                  'Posts',
                  style: TextStyle(
                      fontSize: 18,
                      color: widget.slected == 0 ? kc10 : kc30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     if (mounted) {
              //       setState(() {
              //         widget.slected = 1;
              //       });
              //     }
              //   },
              //   child: Text(
              //     'Updates',
              //     style: TextStyle(
              //         fontSize: 18,
              //         color: widget.slected == 1 ? kc10 : kc30,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.slected = 2;
                    });
                  }
                },
                child: Text(
                  'Bio',
                  style: TextStyle(
                      fontSize: 18,
                      color: widget.slected == 2 ? kc10 : kc30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          widget.slected == 0
              ? Divider(
                  height: 10,
                  thickness: 3,
                  indent: size.width * .2,
                  endIndent: size.width * .55,
                  color: kc30,
                )
              : Divider(
                  height: 10,
                  thickness: 3,
                  indent: size.width * .59,
                  endIndent: size.width * .21,
                  color: kc30,
                ),

          kheight20,
          widget.slected == 2
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 62, 62, 62).withOpacity(.5),
                          gradient: pinglet,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.work),
                              title: Text(
                                widget.myPDoc['job'],
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.mail),
                              title: Text(
                                '${widget.myDoc['email']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone_android),
                              title: Text(
                                '${widget.myDoc['phone']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.history),
                              title: Text(
                                'Experience : ${widget.myPDoc['experience']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.star),
                              title: Text(
                                'Rating : ${widget.myPDoc['rating']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: size.width * .55,
                                child: Text(
                                  '\t\t\t\t\t\t\t\t\t\t${widget.myPDoc['details']}',
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    color: kc30,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            kheight,
                            Divider(
                              height: 5,
                              thickness: 3,
                              endIndent: size.width * .2,
                              indent: size.width * .2,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Updates',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * .3,
                              decoration: const BoxDecoration(
                                  color: kc30,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget.det.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: socialLive,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.det[index],
                                            style: const TextStyle(
                                                color: kc60,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Text(
                                                widget.dates2[index],
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 198, 198, 198),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    // decoration: BoxDecoration(gradient: pinglet),
                    child: GridView.builder(
                      itemCount: widget.url.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  backgroundColor: kc30,
                                  content: SizedBox(
                                    height: size.height * .6,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Hero(
                                              tag: widget.url[index],
                                              child: Image.network(
                                                widget.url[index],
                                                fit: BoxFit.fitWidth,
                                              ),
                                            )),
                                        Expanded(
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      kwidth20,
                                                      const Text(
                                                        'Likes : ',
                                                        style: TextStyle(
                                                            color: kc60,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '${widget.likesList[index]}',
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Spacer(),
                                                      Text(
                                                        widget.dates[index],
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  kheight,
                                                  Text(
                                                    widget.det[index],
                                                    style: const TextStyle(
                                                        color: kc60,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: widget.url[index],
                                  child: Image.network(
                                    widget.url[index],
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                )
          // : Expanded(
          //     child: Container(
          //       decoration: BoxDecoration(gradient: pinglet),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(
          //             vertical: 5, horizontal: 2),
          //         child: GridView.custom(
          //           // semanticChildCount: widget.det.length,
          //           scrollDirection: Axis.horizontal,
          //           gridDelegate: SliverStairedGridDelegate(
          //             crossAxisSpacing: 48,
          //             mainAxisSpacing: 24,
          //             startCrossAxisDirectionReversed: true,
          //             pattern: [
          //               StairedGridTile(0.5, 1),
          //               StairedGridTile(0.5, 3 / 4),
          //               StairedGridTile(1.0, 7 / 4),
          //             ],
          //           ),
          //           childrenDelegate: SliverChildBuilderDelegate(
          //             childCount: widget.det.length,
          //             (context, index) => GridTile(
          //                 child: Container(
          //               decoration: BoxDecoration(
          //                   gradient: socialLive,
          //                   borderRadius: BorderRadius.circular(20)),
          // child: Center(
          //     child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SingleChildScrollView(
          //     child: Text(
          //       widget.det[index],
          //       style: const TextStyle(
          //           color: kc30,
          //           fontSize: 15,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // )),
          //             )),
          //           ),
          //         ),
          //       ),
          //     ),
          //   )

          //  GridView.builder(
          //   itemCount: widget.det.length,
          //   gridDelegate:
          //       const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 4.0,
          //           mainAxisSpacing: 4.0),
          //   itemBuilder: (BuildContext context, int index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(4.0),
          //       child: Container(
          //           decoration: BoxDecoration(
          //             color: kc10.withOpacity(.8),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Center(
          //               child: Text(
          //             widget.det[index],
          //             style: const TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold),
          //           ))),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
