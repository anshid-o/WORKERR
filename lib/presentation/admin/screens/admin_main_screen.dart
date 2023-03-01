import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/presentation/admin/screens/Manage/manage.dart';
import 'package:workerr_app/presentation/admin/screens/feedback/admin_feedback.dart';
import 'package:workerr_app/presentation/admin/screens/home/admin_home.dart';
// import 'package:workerr_app/presentation/admin/screens/home/admin_home.dart';
import 'package:workerr_app/presentation/admin/screens/profile/admin_profile.dart';
import 'package:workerr_app/presentation/admin/screens/report/admin_report.dart';

class AdminScreenMain extends StatefulWidget {
  const AdminScreenMain({Key? key}) : super(key: key);

  @override
  State<AdminScreenMain> createState() => _AdminScreenMainState();
}

class _AdminScreenMainState extends State<AdminScreenMain> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kc30,
      body: buildAdminPages(),
      bottomNavigationBar: buidAdminbottomNavBAr(),
    );
  }

  Widget buidAdminbottomNavBAr() {
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
            Icons.manage_accounts,
          ),
          title: const Text('Manage'),
        ),
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(
            Icons.report_problem,
          ),
          title: const Text('Reports'),
        ),
        BottomNavyBarItem(
          activeColor: kc10,
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          icon: const Icon(
            Icons.feedback,
          ),
          title: const Text('Feedbacks'),
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
        setState(() {
          this.index = index;
        });
      },
    );
  }

  Widget buildAdminPages() {
    switch (index) {
      case 1:
        return const ManageUsers();
      case 2:
        return AdminReportScreen();
      case 3:
        return AdminFeedback();
      case 4:
        return const AdminProfile();

      case 0:

      default:
        return AdminHomeScreen();
    }
  }
}



// class WorkerrApp extends StatelessWidget {
//   const WorkerrApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
