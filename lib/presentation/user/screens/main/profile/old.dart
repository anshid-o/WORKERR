// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:workerr_app/core/colors.dart';
// import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/domain/firebase_helper.dart';
// import 'package:workerr_app/presentation/user/Good/backend/users.dart';
// import 'package:workerr_app/presentation/user/screens/main/profile/information.dart';
// import 'package:workerr_app/presentation/user/screens/main/profile/screen_report.dart';
// import 'package:workerr_app/presentation/user/screens/main/profile/work_status.dart';
// // import 'package:workerr_app/presentation/user/screens/home/profile/update_availability.dart';
// import 'package:workerr_app/presentation/user/screens/main/profile/update_profile.dart';
// // import 'package:workerr_app/presentation/user/screens/screen_main.dart';
// // import 'package:workerr_app/presentation/user/screens/home/profile/update_profile.dart';
// // import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
// // import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';
// import 'package:workerr_app/presentation/user/widgets/profile_menu_widget.dart';

// class ScreenProfile extends StatefulWidget {
//   const ScreenProfile({Key? key}) : super(key: key);

//   @override
//   State<ScreenProfile> createState() => _ScreenProfileState();
// }

// class _ScreenProfileState extends State<ScreenProfile> {
//   Service service = Service();
//   bool fetching = true;
//   late int i;
//   final storeUser = FirebaseFirestore.instance;
//   final user = FirebaseAuth.instance.currentUser!;
//   List<Wusers> usersList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     fetchRecords();
//     super.initState();
//   }

//   fetchRecords() async {
//     var records = await FirebaseFirestore.instance.collection('Users').get();
//     mapRecords(records);
//   }

//   mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
//     var rusers = records.docs
//         .map((item) => Wusers(
//             email: item['email'],
//             status: item['status'],
//             name: item['name'],
//             password: item['password'],
//             phone: item['phone'],
//             pin: item['pin'],
//             uid: item.id))
//         .toList();

//     setState(() {
//       usersList = rusers;
//     });
//     i = 0;
//     while (usersList[i].uid != user.uid) {
//       if (i > usersList.length) {
//         break;
//       }
//       i = i + 1;
//     }
//   }

// // final _page=UpdateProfile();
//   @override
//   build(BuildContext context) {
//     // storeUser.
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kc30,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(55),
//           child: AppBar(
//             backgroundColor: kc30.withGreen(18),
//             automaticallyImplyLeading: false,
//             title: const Text(
//               'Profile',
//               style: TextStyle(
//                   color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             // actions: [
//             //   IconButton(
//             //     tooltip: 'Top Workers',
//             //     onPressed: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => const MyTabbedAppBar(),
//             //         ),
//             //       );
//             //     },
//             //     icon: const Icon(
//             //       CupertinoIcons.person_3_fill,
//             //       color: kc10,
//             //       size: 30,
//             //       shadows: kshadow2,
//             //     ),
//             //   ),
//             //   kwidth
//             // ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     SizedBox(
//                       width: 120,
//                       height: 120,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: const Image(
//                               image: AssetImage('assets/mine.jpg'))),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         width: 35,
//                         height: 35,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: kc10),
//                         child: const Icon(
//                           Icons.edit,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 kheight,
//                 Text(usersList.isNotEmpty ? usersList[i].name : 'Loading...',
//                     style: const TextStyle(
//                       color: kc60,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     )),

//                 Text(usersList.isNotEmpty ? usersList[i].email : 'Loading...',
//                     style: const TextStyle(
//                       color: kc60,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                     )),
//                 kheight20,
//                 SizedBox(
//                   width: 200,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (ctx) => UpdateProfile()));
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(kc10),
//                       // elevation: MaterialStateProperty.all(4.0),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       'Edit Profile',
//                       style: TextStyle(
//                           color: kc60,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 kheight,

//                 kheight,
//                 // Menu
//                 ProfileMenuWidget(
//                   title: usersList.isNotEmpty ? usersList[i].status : 'Loading',
//                   icon: CupertinoIcons.settings_solid,
//                   onpress: () {},
//                 ),
//                 ProfileMenuWidget(
//                   title: 'Update Work',
//                   icon: Icons.work,
//                   onpress: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (ctx) => ScreenSpacifyWork(name:'' ,)));
//                   },
//                 ),
//                 ProfileMenuWidget(
//                   isSwitch: true,
//                   title: 'Availability',
//                   icon: Icons.event_available,
//                   onpress: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (ctx) => const UpdateAvailability()));
//                   },
//                 ),
//                 ProfileMenuWidget(
//                   title: 'Report',
//                   icon: Icons.report_problem_rounded,
//                   onpress: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (ctx) => ScreenReport()));
//                   },
//                 ),
//                 const Divider(),
//                 ProfileMenuWidget(
//                   title: 'Information',
//                   icon: CupertinoIcons.info_circle_fill,
//                   onpress: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (ctx) => const Information()));
//                   },
//                 ),
//                 ProfileMenuWidget(
//                   title: 'Logout',
//                   textColor: kred,
//                   icon: Icons.logout,
//                   endIcon: false,
//                   onpress: () async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     prefs.remove('email');
//                     service.signOutUser(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
