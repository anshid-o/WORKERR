import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

// import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
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

  final auth = FirebaseAuth.instance;
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
    const ScreenPost(),
    ScreenChat(),
    // const ScreenTopList(),
    const MyTabbedAppBar(),
    ScreenRequest(),
    ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      backgroundColor: kc30,
      // body: ValueListenableBuilder(
      //   valueListenable: indexChangeNotifier,
      //   builder: (context, int index, _) {
      //     return _pages[index];
      //   },
      // ),
      body: buildPages(),
      bottomNavigationBar: buidbottomNavBAr(),
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
        return const ScreenPost();
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
