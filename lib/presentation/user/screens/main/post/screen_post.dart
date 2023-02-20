import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'dart:io' as i;
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/home/my%20works/screen_home.dart';
import 'package:workerr_app/presentation/user/screens/main/post/dummy.dart';
import 'package:workerr_app/presentation/user/screens/main/post/new_show_workers.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
// import 'package:workerr_app/presentation/user/screens/screen_main.dart';
// import 'package:workerr_app/presentation/user/screens/home/profile/update_work.dart';
// import 'package:workerr_app/presentation/user/screens/home/profile/work_status.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/screens/my_tabbed_appbar.dart';

class ScreenPost extends StatefulWidget {
  const ScreenPost({Key? key}) : super(key: key);

  @override
  State<ScreenPost> createState() => _ScreenPostState();
}

class _ScreenPostState extends State<ScreenPost> {
  TextEditingController wdet = TextEditingController();
  TextEditingController pdet = TextEditingController();
  XFile? file;
  String imageUrl = '';
  int count = -1;
  List<String> works = [
    'Plumbing',
    'Painting',
    'Fabrication works',
    'Electric repairs',
    'Mechanic',
    'Driver'
  ];
  String selectedItem = 'Plumbing';
  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;
  getData() async {
    final a = await FirebaseFirestore.instance.collection("Workers").get();
    if (mounted) {
      for (var element in a.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          setState(() {
            count = 1;
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: kc30,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * .15),
            child: AppBar(
              // surfaceTintColor: kc302,
              backgroundColor: kc30.withGreen(18),
              automaticallyImplyLeading: false,
              title: const Text(
                'Post a Work',
                style: TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  tooltip: 'Top Workers',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyTabbedAppBar(),
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.person_3_fill,
                    color: kc10,
                    size: 30,
                    shadows: kshadow2,
                  ),
                ),
                kwidth
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Request work',
                    icon: Icon(Icons.work),
                  ),
                  Tab(
                    text: 'Post work',
                    icon: Icon(Icons.workspace_premium),
                  )
                ],
                indicatorColor: kc10,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/lottie/humanres.json',
                      height: size.height * .25,
                    ),
                    // const CircleAvatar(
                    //   radius: 50,
                    //   backgroundColor: Colors.transparent,
                    //   child: Icon(
                    //     CupertinoIcons.mail,
                    //     color: kc60,
                    //     shadows: kshadow2,
                    //     size: 70,
                    //   ),
                    // ),

                    Container(
                      width: 360,
                      // height: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          gradient: const SweepGradient(
                              tileMode: TileMode.repeated,
                              center: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 228, 222, 222),
                                Colors.white
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            InkWell(
                              onDoubleTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RequestedPage(),
                                    ));
                              },
                              child: const Text(
                                "Enter Details",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  // fontStyle: FontStyle.italic,
                                  // backgroundColor: kgold,
                                  color: kc30,

                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  // decoration: TextDecoration.underline,
                                  // decorationThickness: 1.3,
                                  // decorationColor: kred,
                                ),
                              ),
                            ),
                            kheight30,
                            kheight,

                            Row(
                              children: [
                                const Text(
                                  'Type of Work : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: size.width * .5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 229, 229, 229)),
                                  child: DropdownButtonFormField<String>(
                                    // dropdownColor: ,
                                    // iconSize: 20,
                                    elevation: 8,
                                    // autofocus: true,
                                    decoration: InputDecoration(
                                        fillColor: kgold,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 2, color: kc10))),
                                    value: selectedItem,
                                    items: works
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (item) {
                                      if (mounted) {
                                        setState(() {
                                          selectedItem = item!;
                                        });
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            // MyTextForm(
                            //     name: 'Work', icon: Icons.work_outline_rounded),
                            kheight30,
                            kheight,
                            TextFormField(
                              controller: wdet,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: kc10.withOpacity(.1),
                                label: const Text(
                                  'Details',
                                  textAlign: TextAlign.start,
                                ),
                                prefixIcon: const Icon(CupertinoIcons.info),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kc10, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 54, 9, 62)),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kc10, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                border: const UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),

                            // kheight30,
                          ],
                        ),
                      ),
                    ),
                    kheight20,
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (wdet.text.isNotEmpty) {
                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final now = DateTime.now();
                                String formatter =
                                    DateFormat('yMd').format(now);
                                // print('user not null');
                                storeUser
                                    .collection("Works")
                                    .doc(now.toString())
                                    .set({
                                  'uid': user.uid,
                                  'work': selectedItem,
                                  'details': wdet.text,
                                  'status': 'Requested',
                                  'date': formatter,
                                  'time': now
                                });
                                wdet.text = '';

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => NewShowWorkers(
                                              details: wdet.text,
                                              id: now.toString(),
                                              work: selectedItem,
                                            )));
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: kc30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      title: const Text(
                                        'Error',
                                        style: TextStyle(color: kc60),
                                      ),
                                      content: Text(e.toString(),
                                          style: const TextStyle(color: kc60)),
                                    );
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: kc30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    title: const Text(
                                      'Error',
                                      style: TextStyle(color: kc60),
                                    ),
                                    content: const Text(
                                      'Fields must be filled',
                                      style: TextStyle(color: kc60),
                                    ),
                                  );
                                });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kc10),
                          // elevation: MaterialStateProperty.all(4.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Post Work',
                          style: TextStyle(
                              color: Colors.white,
                              shadows: kshadow2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              count == 1
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/lottie/businessman.json',
                            height: size.height * .25,
                          ),
                          Container(
                            width: 360,
                            height: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                gradient: const SweepGradient(
                                    tileMode: TileMode.repeated,
                                    center: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Color.fromARGB(255, 228, 222, 222),
                                      Colors.white
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onDoubleTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RequestedPage(),
                                          ));
                                    },
                                    child: const Text(
                                      "Enter Details",
                                      // textAlign: TextAlign.start,
                                      style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        // backgroundColor: kgold,
                                        color: kc30,

                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        // decoration: TextDecoration.underline,
                                        // decorationThickness: 1.3,
                                        // decorationColor: kred,
                                      ),
                                    ),
                                  ),
                                  kheight30,
                                  kheight,

                                  // MyTextForm(
                                  //     name: 'Work', icon: Icons.work_outline_rounded),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                        stream: storeUser
                                            .collection("Users")
                                            .where("uid",
                                                isEqualTo:
                                                    auth.currentUser!.uid)
                                            .snapshots(),
                                        // .where({"status", "is", "Requested"}).snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError)
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: 60,
                                                  backgroundColor: kc60,
                                                ),
                                              );
                                            default:
                                              DocumentSnapshot document =
                                                  snapshot.data!.docs[0];
                                              ImageProvider image = document[
                                                          'imageUrl'] ==
                                                      ''
                                                  ? const AssetImage(
                                                      'assets/persons/default.jpg')
                                                  : NetworkImage(
                                                          document['imageUrl'])
                                                      as ImageProvider;
                                              return snapshot
                                                      .data!.docs.isNotEmpty
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 8, 8, 8),
                                                      child: CircleAvatar(
                                                        radius:
                                                            size.width * .08,
                                                        backgroundColor: kc30,
                                                        backgroundImage: image,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          30, 100, 30, 0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: kc60,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'You are not posted any works yet.',
                                                            style: TextStyle(
                                                                fontSize: 30,
                                                                color: kc30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                          }
                                        },
                                      ),
                                      kwidth,
                                      SizedBox(
                                        width: size.width * .6,
                                        child: TextFormField(
                                          controller: pdet,
                                          minLines: 4,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kc10.withOpacity(.1),
                                            label: const Text(
                                              'Whats you done?',
                                              textAlign: TextAlign.start,
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kc10, width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            hintText:
                                                'Simply explain about your work',
                                            hintStyle: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kc10, width: 3.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            border: const UnderlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .16,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await showOptionsDialog(context);
                                            // print(file!.path);
                                            if (file != null) {
                                              String uniqueFileName =
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDirImages =
                                                  referenceRoot
                                                      .child('Usersimages');
                                              Reference referenceImageToUpload =
                                                  referenceDirImages
                                                      .child(uniqueFileName);
                                              i.File f = i.File(file!.path);
                                              try {
                                                await referenceImageToUpload
                                                    .putFile(f);
                                                imageUrl =
                                                    await referenceImageToUpload
                                                        .getDownloadURL();
                                                if (imageUrl == '') {
                                                  ProgressIndicator;
                                                }
                                                if (imageUrl.isEmpty) {
                                                  showDone(
                                                      context,
                                                      'Please upload an image',
                                                      Icons.error,
                                                      Colors.red);
                                                }
                                                // firebase
                                                //     .collection("Users")
                                                //     .doc(user.uid)
                                                //     .update({'imageUrl': imageUrl});
                                              } catch (e) {
                                                print('Error ' + e.toString());
                                              }
                                            }
                                          },
                                          icon: Icon(
                                            Icons.broken_image_outlined,
                                            size: 40,
                                            color: kc10.shade700,
                                          ),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(
                                        //     Icons.emoji_emotions_outlined,
                                        //     size: 35,
                                        //     color: kc10.shade700,
                                        //   ),
                                        // ),
                                        const Spacer(),
                                        ElevatedButton.icon(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: const BorderSide(
                                                          width: .8,
                                                          color: kc30)))),
                                          onPressed: () async {
                                            if (pdet.text.isNotEmpty) {
                                              try {
                                                final user = FirebaseAuth
                                                    .instance.currentUser;
                                                if (user != null) {
                                                  final now = DateTime.now();
                                                  String formatter =
                                                      DateFormat('yMd')
                                                          .format(now);
                                                  // print('user not null');
                                                  dynamic x;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Workers')
                                                      .where('uid',
                                                          isEqualTo: user.uid)
                                                      .where('status',
                                                          isEqualTo: 'Verified')
                                                      .get()
                                                      .then((value) =>
                                                          x = value.docs);
                                                  dynamic y = x[0];
                                                  await storeUser
                                                      .collection("Posts")
                                                      .doc()
                                                      .set({
                                                    'uid': user.uid,
                                                    'work': y['job'],
                                                    'imageUrl': imageUrl,
                                                    // x.data!.data()!["work"],
                                                    'details': pdet.text,
                                                    'like': 0,
                                                    'date': formatter,
                                                    'time': now
                                                  });

                                                  Navigator.popAndPushNamed(
                                                      context, 'main');
                                                }
                                              } catch (e) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor: kc30,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        title: const Text(
                                                          'Error',
                                                          style: TextStyle(
                                                              color: kc60),
                                                        ),
                                                        content: Text(
                                                            e.toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color:
                                                                        kc60)),
                                                      );
                                                    });
                                              }
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: kc30,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      title: const Text(
                                                        'Error',
                                                        style: TextStyle(
                                                            color: kc60),
                                                      ),
                                                      content: const Text(
                                                        'Fields must be filled',
                                                        style: TextStyle(
                                                            color: kc60),
                                                      ),
                                                    );
                                                  });
                                            }
                                          },
                                          icon: const Icon(CupertinoIcons.add),
                                          label: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'Post',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // kheight30,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Center(
                            child: Lottie.asset('assets/lottie/safety.json',
                                repeat: false)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: size.height * .15,
                            decoration: BoxDecoration(
                                color: kc60,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Only verified workers can post their works !',
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: kc30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showOptionsDialog(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
              title: const Text(
                'Profle photo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: size.width * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera_alt),
                              ),
                            ),
                            kheight,
                            const Text('Camera')
                          ],
                        ),
                        kwidth,
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                              ),
                            ),
                            kheight,
                            const Text('Gallery')
                          ],
                        ),
                        kwidth,
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.man),
                              ),
                            ),
                            kheight,
                            const Text('Avatar')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
