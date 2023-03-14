import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/build_list.dart';
import 'package:workerr_app/presentation/user/screens/main/post/search.dart';

// import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class NewShowWorkers extends StatefulWidget {
  String work;
  String details;
  String id;
  NewShowWorkers(
      {Key? key, required this.details, required this.id, required this.work})
      : super(key: key);

  bool tick = false;
  bool isPressed = false;
  List<String> toplist = [];
  bool isDescending = false;

  List<String> pinCodes = [
    'Pin Codes',
    '673661',
    '673662',
    '673624',
    '673667',
    '673672',
  ];
  int pi = 0;
  String selectedPin = 'Pin Codes';

  List<String> districts = [
    'Districts',
    'Kozhikkode',
    'Malappuram',
    'Kannur',
    'Vayanadu',
    'Thrissur',
  ];
  String selectedDis = 'Districts';
  int dis = 0;

  List<String> rating = [
    'Rating',
    '>  2 Star',
    '>  2.5 Star',
    '>  3 Star',
    '>  3.5 Star',
    '>  4 Star',
    '>  4.5 Star',
    '   5 Star',
  ];
  double rt = 0;
  String selectedrating = 'Rating';
  List<String> widList = [];
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  State<NewShowWorkers> createState() => _NewShowWorkersState();
}

class _NewShowWorkersState extends State<NewShowWorkers> {
  getList() async {
    await widget.firebase
        .collection('Favorites')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              widget.widList.add(element['wid']);
            }));
  }

  getStream() {
    if (widget.tick) {
      if (widget.widList.isNotEmpty) {
        if (widget.dis == 0) {
          if (widget.pi == 0) {
            return widget.firebase
                .collection("Workers")
                .where('rating', isGreaterThanOrEqualTo: widget.rt)
                .where('uid', whereIn: widget.widList)
                .where('job', isEqualTo: widget.work)
                .snapshots();
          } else {
            return widget.firebase
                .collection("Workers")
                .where('pin', isEqualTo: widget.pinCodes[widget.pi])
                .where('uid', whereIn: widget.widList)
                .where('rating', isGreaterThanOrEqualTo: widget.rt)
                .where('job', isEqualTo: widget.work)
                .snapshots();
          }
        } else {
          if (widget.pi == 0) {
            return widget.firebase
                .collection("Workers")
                .where('district', isEqualTo: widget.districts[widget.dis])
                .where('uid', whereIn: widget.widList)
                .where('rating', isGreaterThanOrEqualTo: widget.rt)
                .where('job', isEqualTo: widget.work)
                .snapshots();
          } else {
            return widget.firebase
                .collection("Workers")
                .where('pin', isEqualTo: widget.pinCodes[widget.pi])
                .where('district', isEqualTo: widget.districts[widget.dis])
                .where('uid', whereIn: widget.widList)
                .where('rating', isGreaterThanOrEqualTo: widget.rt)
                .where('job', isEqualTo: widget.work)
                .snapshots();
          }
        }
      }
    } else {
      if (widget.dis == 0) {
        if (widget.pi == 0) {
          return widget.firebase
              .collection("Workers")
              .where('rating', isGreaterThanOrEqualTo: widget.rt)
              .where('job', isEqualTo: widget.work)
              .snapshots();
        } else {
          return widget.firebase
              .collection("Workers")
              .where('pin', isEqualTo: widget.pinCodes[widget.pi])
              .where('rating', isGreaterThanOrEqualTo: widget.rt)
              .where('job', isEqualTo: widget.work)
              .snapshots();
        }
      } else {
        if (widget.pi == 0) {
          return widget.firebase
              .collection("Workers")
              .where('district', isEqualTo: widget.districts[widget.dis])
              .where('rating', isGreaterThanOrEqualTo: widget.rt)
              .where('job', isEqualTo: widget.work)
              .snapshots();
        } else {
          return widget.firebase
              .collection("Workers")
              .where('pin', isEqualTo: widget.pinCodes[widget.pi])
              .where('district', isEqualTo: widget.districts[widget.dis])
              .where('rating', isGreaterThanOrEqualTo: widget.rt)
              .where('job', isEqualTo: widget.work)
              .snapshots();
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.white,
          // bottomOpacity: 0,
          // foregroundColor: Colors.white,
          backgroundColor: kc602,
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(children: const [
            Text(
              'Request',
              style: TextStyle(
                color: kc30,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          actions: [
            IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    widget.isDescending = !widget.isDescending;
                  });
                }
              },
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.compare_arrows,
                  size: 28,
                  color: kc10,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeachPage(
                          id: widget.id,
                          work: widget.work,
                        ),
                      ));
                  // showSearch(context: context, delegate: CustomSeachDeligate());
                },
                icon: const Icon(
                  Icons.search,
                  color: kc10,
                ))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getStream(),
          // .where({"status", "is", "Requested"}).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                // int length = snapshot.data!.docs.length;
                // bool checkFlag = false;
                // for (var element in snapshot.data!.docs) {
                //   if (element['uid'] ==
                //       FirebaseAuth.instance.currentUser!.uid) {
                //     checkFlag = true;
                //   }
                // }
                return snapshot.data!.docs.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: kc30,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  kwidth,
                                  const Icon(
                                    Icons.filter_list_rounded,
                                    color: kc10,
                                  ),
                                  kwidth,
                                  const Center(
                                    child: Text(
                                      'Filters',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  kwidth,
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc30,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        // borderRadius: BorderRadius.circular(0),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  width: 2.2,
                                                  color: kc10,
                                                ))),
                                        value: widget.selectedDis,
                                        items: widget.districts
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedDis = item!;
                                              widget.dis = widget.districts
                                                  .indexOf(item);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc30,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    width: 2.2, color: kc10))),
                                        value: widget.selectedPin,
                                        items: widget.pinCodes
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedPin = item!;
                                              widget.pi =
                                                  widget.pinCodes.indexOf(item);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc10,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    width: 2.2, color: kc10))),
                                        value: widget.selectedrating,
                                        items: widget.rating
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedrating = item!;
                                              switch (
                                                  widget.rating.indexOf(item)) {
                                                case 1:
                                                  widget.rt = 2;
                                                  break;
                                                case 2:
                                                  widget.rt = 2.5;
                                                  break;
                                                case 3:
                                                  widget.rt = 3;
                                                  break;
                                                case 4:
                                                  widget.rt = 3.5;
                                                  break;
                                                case 5:
                                                  widget.rt = 4;
                                                  break;
                                                case 6:
                                                  widget.rt = 4.5;
                                                  break;
                                                case 7:
                                                  widget.rt = 5;
                                                  break;

                                                default:
                                                  widget.rt = 5;
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kc10, width: 2.5),
                                          // color: kc10.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 20, 5, 20),
                                            child: Text(
                                              'Filter by my Favorite :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Checkbox(
                                              activeColor: Colors.green,
                                              checkColor: kc60,
                                              value: widget.tick,
                                              onChanged: (value) {
                                                if (mounted) {
                                                  setState(() {
                                                    widget.tick = value!;
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot document =
                                      snapshot.data!.docs[index];
                                  return document['uid'] !=
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? BuildList(
                                          index: index,
                                          myDoc: document,
                                          rating: double.parse(
                                              document['rating'].toString()),
                                          id: widget.id,
                                          det: widget.details,
                                          isdec: widget.isDescending,
                                          work: widget.work,
                                        )
                                      : Center();
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: kc30gd),
                              child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      side: const BorderSide(
                                          color: kc60, width: 3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    showDone(
                                        context,
                                        'work successfully posted',
                                        Icons.done,
                                        Colors.green);
                                    Navigator.pop(context);
                                  },
                                  // onLongPress: () {
                                  //   // Navigator.pop(context);
                                  // },
                                  // child: Listener(
                                  //   onPointerDown: (event) {
                                  //     if (mounted) {
                                  //       setState(() {
                                  //         widget.isPressed = true;
                                  //       });
                                  //     }
                                  //   },
                                  //   onPointerUp: (event) {
                                  //     if (mounted) {
                                  //       setState(() {
                                  //         widget.isPressed = false;
                                  //       });
                                  //     }
                                  //   },
                                  child: Center(
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        shadows: [
                                          for (double i = 1;
                                              i < (widget.isPressed ? 10 : 6);
                                              i++)
                                            const Shadow(
                                              color: kshadowColor,
                                              blurRadius: 3,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: kc30,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  kwidth,
                                  const Icon(
                                    Icons.filter_list_rounded,
                                    color: kc10,
                                  ),
                                  kwidth,
                                  const Center(
                                    child: Text(
                                      'Filters',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  kwidth,
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc30,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        // borderRadius: BorderRadius.circular(0),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  width: 2.2,
                                                  color: kc10,
                                                ))),
                                        value: widget.selectedDis,
                                        items: widget.districts
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedDis = item!;
                                              widget.dis = widget.districts
                                                  .indexOf(item);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc30,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    width: 2.2, color: kc10))),
                                        value: widget.selectedPin,
                                        items: widget.pinCodes
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedPin = item!;
                                              widget.pi =
                                                  widget.pinCodes.indexOf(item);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 165,
                                      child: DropdownButtonFormField<String>(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: kc10,
                                        focusColor: Colors.amber,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    width: 2.2, color: kc10))),
                                        value: widget.selectedrating,
                                        items: widget.rating
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) {
                                          if (mounted) {
                                            setState(() {
                                              widget.selectedrating = item!;
                                              switch (
                                                  widget.rating.indexOf(item)) {
                                                case 1:
                                                  widget.rt = 2;
                                                  break;
                                                case 2:
                                                  widget.rt = 2.5;
                                                  break;
                                                case 3:
                                                  widget.rt = 3;
                                                  break;
                                                case 4:
                                                  widget.rt = 3.5;
                                                  break;
                                                case 5:
                                                  widget.rt = 4;
                                                  break;
                                                case 6:
                                                  widget.rt = 4.5;
                                                  break;
                                                case 7:
                                                  widget.rt = 5;
                                                  break;

                                                default:
                                                  widget.rt = 5;
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kc10, width: 2.5),
                                          // color: kc10.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 20, 5, 20),
                                            child: Text(
                                              'Filter by my Favorite :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Checkbox(
                                              activeColor: Colors.green,
                                              checkColor: kc60,
                                              value: widget.tick,
                                              onChanged: (value) {
                                                if (mounted) {
                                                  setState(() {
                                                    widget.tick = value!;
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kc602,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'There are no workers who capable to do ${widget.work}.',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: kc30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
            }
          },
        ));
  }
}
