import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: newIndex,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              backgroundColor: Colors.black,
              selectedItemColor: kgold,
              unselectedItemColor: Colors.grey,
              unselectedFontSize: 12,
              // enableFeedback: true,
              selectedIconTheme: const IconThemeData(color: kgold, size: 30),
              unselectedIconTheme:
                  const IconThemeData(color: Colors.grey, size: 25),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.quote_bubble), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chart_bar_square), label: 'List'),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.globe,
                    ),
                    label: 'Request'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'Profile'),
              ]);
        });
  }
}


// bottomNavigationBar: CurvedNavigationBar(
//         index: 1,
//         height: 60,
//         color: const Color(0xffe1e2e3),
//         backgroundColor: Colors.white,
//         items: const <Widget>[
//           Icon(Icons.list, size: 30),
//           Icon(Icons.home, size: 30),
//           Icon(Icons.settings, size: 30),
//         ],
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 300),
//       ),