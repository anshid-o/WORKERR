import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

// import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/user/screens/authentication/login.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/screen_chat.dart';
import 'package:workerr_app/presentation/user/screens/main/home/screen_home.dart';
import 'package:workerr_app/presentation/user/screens/main/post/screen_post.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/screen_profile.dart';
import 'package:workerr_app/presentation/user/screens/main/screen_request.dart';
// import 'package:workerr_app/presentation/user/screens/home/screen_toplist.dart';
import 'package:workerr_app/presentation/user/widgets/bottom_nav.dart';
import 'package:workerr_app/presentation/user/screens/my_tabbed_appbar.dart';

// import 'home/screen_toplist.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int index = 0;
  int count = -1;
  Service service = Service();

  String rsn = '';
  final auth = FirebaseAuth.instance;
  getData() async {
    final a = await FirebaseFirestore.instance.collection("Workers").get();
    final u = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (u.data()!.containsKey('reason')) {
      rsn = u['reason'];
    }
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

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _pages = [
    ScreenHome(),
    ScreenPost(),
    ScreenChat(),
    // const ScreenTopList(),
    const MyTabbedAppBar(),
    ScreenRequest(),
    ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return rsn == ''
        ? WillPopScope(
            onWillPop: () async {
              bool x = false;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Alert !',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Are you sure, You want to exit ?'),
                    actions: [
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          icon: const Icon(Icons.done),
                          label: const Text('Exit')),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('Cancel')),
                    ],
                  );
                },
              ); // Action to perform on back pressed
              return x;
            },
            child: Scaffold(
              backgroundColor: kc30,
              // body: ValueListenableBuilder(
              //   valueListenable: indexChangeNotifier,
              //   builder: (context, int index, _) {
              //     return _pages[index];
              //   },
              // ),
              body: buildPages(),
              bottomNavigationBar: buidbottomNavBAr(),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              // Action to perform on back pressed
              return false;
            },
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: kc60),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Your account was banned by admin!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kc30,
                            fontSize: 25,
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        'Reason :$rsn',
                        style: const TextStyle(
                            color: kc30,
                            fontSize: 20,
                            decoration: TextDecoration.none),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                                (route) => false);
                          },
                          child: const Text('Exit'))
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget buidbottomNavBAr() {
    return BottomNavyBar(
      itemCornerRadius: 12,
      containerHeight: 65,
      backgroundColor: kc30,
      selectedIndex: index,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(
            Icons.home,
          ),
          title: const Text('Home'),
        ),
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(
            Icons.add_circle,
          ),
          title: const Text('Post'),
        ),
        BottomNavyBarItem(
          activeColor: Colors.teal,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(CupertinoIcons.quote_bubble),
          title: const Text('Chat'),
        ),
        // BottomNavyBarItem(
        //     icon: const Icon(CupertinoIcons.chart_bar_square),
        //     title: const Text('List')),
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: count == 1
              ? const Icon(
                  CupertinoIcons.globe,
                )
              : const Icon(Icons.lock),
          title: const Text('Request'),
        ),
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(
            CupertinoIcons.person,
          ),
          title: const Text('Profile'),
        ),
      ],
      onItemSelected: (index) {
        if (mounted) {
          setState(() {
            this.index = index;
          });
        }
      },
    );
  }

  Widget buildPages() {
    switch (index) {
      case 1:
        return ScreenPost();
      case 2:
        return ScreenChat();
      case 3:
        return ScreenRequest();
      case 4:
        return ScreenProfile();
      case 0:

      default:
        return ScreenHome();
    }
  }
}
