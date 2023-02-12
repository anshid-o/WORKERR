import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/build_list.dart';
import 'package:workerr_app/presentation/user/screens/main/post/search.dart';

// import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class ShowWorkers extends StatefulWidget {
  String work;
  String details;
  String id;
  ShowWorkers(
      {Key? key, required this.details, required this.id, required this.work})
      : super(key: key);

  @override
  State<ShowWorkers> createState() => _ShowWorkersState();
}

bool? tick = false;
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
  '< 2 Star',
  '< 2.5 Star',
  '< 3 Star',
  '< 3.5 Star',
  '< 4 Star',
  '< 4.5 Star',
  '< 5 Star',
];
double rt = 5;
String selectedrating = 'Rating';
FirebaseFirestore firebase = FirebaseFirestore.instance;

class _ShowWorkersState extends State<ShowWorkers> {
  bool isPressed = false;
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
              setState(() {
                isDescending = !isDescending;
              });
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
      body: dis == 0
          ? pi == 0
              ? StreamBuilder<QuerySnapshot>(
                  stream: firebase
                      .collection("Workers")
                      .where('rating', isLessThanOrEqualTo: rt)
                      .where('job', isEqualTo: widget.work)
                      .snapshots(),
                  // .where({"status", "is", "Requested"}).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: kc30,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot document =
                                                snapshot.data!.docs[index];
                                            return BuildList(
                                              myDoc: document,
                                              rating: double.parse(
                                                  document['rating']
                                                      .toString()),
                                              id: widget.id,
                                              det: widget.details,
                                              isdec: isDescending,
                                              work: widget.work,
                                            );
                                          })),
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: kc30gd),
                                      child: Center(
                                        child: TextButton(
                                          onHover: (hovered) => setState(() {
                                            isPressed = hovered;
                                          }),
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(
                                                  color: kc60, width: 3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          onLongPress: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              isPressed = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              isPressed = false;
                                            }),
                                            child: Center(
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  shadows: [
                                                    for (double i = 1;
                                                        i <
                                                            (isPressed
                                                                ? 10
                                                                : 6);
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
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 100, 30, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kc602,
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: firebase
                      .collection("Workers")
                      .where('pin', isEqualTo: pinCodes[pi])
                      .where('rating', isLessThanOrEqualTo: rt)
                      .where('job', isEqualTo: widget.work)
                      .snapshots(),
                  // .where({"status", "is", "Requested"}).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: kc30,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot document =
                                                snapshot.data!.docs[index];
                                            return BuildList(
                                              myDoc: document,
                                              rating: double.parse(
                                                  document['rating']
                                                      .toString()),
                                              id: widget.id,
                                              det: widget.details,
                                              isdec: isDescending,
                                              work: widget.work,
                                            );
                                          })),
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: kc30gd),
                                      child: Center(
                                        child: TextButton(
                                          onHover: (hovered) => setState(() {
                                            isPressed = hovered;
                                          }),
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(
                                                  color: kc60, width: 3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          onLongPress: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              isPressed = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              isPressed = false;
                                            }),
                                            child: Center(
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  shadows: [
                                                    for (double i = 1;
                                                        i <
                                                            (isPressed
                                                                ? 10
                                                                : 6);
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
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;

                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 100, 30, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kc602,
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                )
          : pi == 0
              ? StreamBuilder<QuerySnapshot>(
                  stream: firebase
                      .collection("Workers")
                      .where('district', isEqualTo: districts[dis])
                      .where('rating', isLessThanOrEqualTo: rt)
                      .where('job', isEqualTo: widget.work)
                      .snapshots(),
                  // .where({"status", "is", "Requested"}).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: kc30,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot document =
                                                snapshot.data!.docs[index];
                                            return BuildList(
                                              myDoc: document,
                                              rating: double.parse(
                                                  document['rating']
                                                      .toString()),
                                              id: widget.id,
                                              det: widget.details,
                                              isdec: isDescending,
                                              work: widget.work,
                                            );
                                          })),
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: kc30gd),
                                      child: Center(
                                        child: TextButton(
                                          onHover: (hovered) => setState(() {
                                            isPressed = hovered;
                                          }),
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(
                                                  color: kc60, width: 3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          onLongPress: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              isPressed = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              isPressed = false;
                                            }),
                                            child: Center(
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  shadows: [
                                                    for (double i = 1;
                                                        i <
                                                            (isPressed
                                                                ? 10
                                                                : 6);
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
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 100, 30, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kc602,
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: firebase
                      .collection("Workers")
                      .where('pin', isEqualTo: pinCodes[pi])
                      .where('district', isEqualTo: districts[dis])
                      .where('rating', isLessThanOrEqualTo: rt)
                      .where('job', isEqualTo: widget.work)
                      .snapshots(),
                  // .where({"status", "is", "Requested"}).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: kc30,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;
                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot document =
                                                snapshot.data!.docs[index];
                                            return BuildList(
                                              myDoc: document,
                                              rating: double.parse(
                                                  document['rating']
                                                      .toString()),
                                              id: widget.id,
                                              det: widget.details,
                                              isdec: isDescending,
                                              work: widget.work,
                                            );
                                          })),
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: kc30gd),
                                      child: Center(
                                        child: TextButton(
                                          onHover: (hovered) => setState(() {
                                            isPressed = hovered;
                                          }),
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(
                                                  color: kc60, width: 3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          onLongPress: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              isPressed = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              isPressed = false;
                                            }),
                                            child: Center(
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  shadows: [
                                                    for (double i = 1;
                                                        i <
                                                            (isPressed
                                                                ? 10
                                                                : 6);
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
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                // borderRadius: BorderRadius.circular(0),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 2.2,
                                                              color: kc10,
                                                            ))),
                                                value: selectedDis,
                                                items: districts
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedDis = item!;
                                                    dis =
                                                        districts.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc30,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedPin,
                                                items: pinCodes
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedPin = item!;
                                                    pi = pinCodes.indexOf(item);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 165,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                alignment: Alignment.centerLeft,
                                                dropdownColor: kc10,
                                                focusColor: Colors.amber,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 2.2,
                                                                    color:
                                                                        kc10))),
                                                value: selectedrating,
                                                items: rating
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedrating = item!;

                                                    switch (
                                                        rating.indexOf(item)) {
                                                      case 1:
                                                        rt = 2;
                                                        break;
                                                      case 2:
                                                        rt = 2.5;
                                                        break;
                                                      case 3:
                                                        rt = 3;
                                                        break;
                                                      case 4:
                                                        rt = 3.5;
                                                        break;
                                                      case 5:
                                                        rt = 4;
                                                        break;
                                                      case 6:
                                                        rt = 4.5;
                                                        break;
                                                      case 7:
                                                        rt = 5;
                                                        break;

                                                      default:
                                                        rt = 5;
                                                    }
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 20, 5, 20),
                                                    child: Text(
                                                      'Filter by my Favorite :',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: Colors.green,
                                                      checkColor: kc60,
                                                      value: tick,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tick = value;
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 100, 30, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kc602,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                                  ),
                                ],
                              );
                    }
                  },
                ),
    );
  }
}
