import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/admin/authentication/admins.dart';
import 'package:workerr_app/presentation/admin/screens/profile/admin_update_profile.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/information.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/widgets/profile_menu_widget.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final storeUser = FirebaseFirestore.instance;
  Service service = Service();
  late int i;
  final user = FirebaseAuth.instance.currentUser!;
  List<Wadmins> adminsList = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('Admins').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var radmins = records.docs
        .map((item) => Wadmins(
            email: item['email'],
            name: item['name'],
            password: item['password'],
            uid: item.id))
        .toList();

    setState(() {
      adminsList = radmins;
    });
    i = 0;
    while (adminsList[i].email != user.email) {
      if (i > adminsList.length) {
        break;
      }
      i = i + 1;
    }
  }

// final _page=UpdateProfile();
  @override
  Widget build(BuildContext context) {
    // int i = 0;

    // while (adminsList[i].email != user.email && i <= adminsList.length) {
    //   i = i + 1;
    // }
    return SafeArea(
      child: Scaffold(
        backgroundColor: kc30,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            backgroundColor: kc30.withGreen(18),
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                  color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 120,
                    color: kc10,
                  ),
                ),
                kheight,
                Text(
                    adminsList.isNotEmpty
                        ? adminsList[i].name[0].toUpperCase() +
                            adminsList[i].name.substring(1)
                        : 'Loading..',
                    style: const TextStyle(
                      color: kc602,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    )),
                Text(adminsList.isNotEmpty ? adminsList[i].email : 'Loading...',
                    style: const TextStyle(
                      color: kc602,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
                kheight20,
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => AdminProfileUpdate()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kc10),
                      // elevation: MaterialStateProperty.all(4.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: kc60,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                kheight30,
                const Divider(),
                kheight,
                // Menu
                ProfileMenuWidget(
                  title: 'Settings',
                  icon: Icons.settings_outlined,
                  onpress: () {},
                ),
                ProfileMenuWidget(
                  title: 'Manage Advertisement',
                  icon: Icons.ads_click_rounded,
                  onpress: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ScreenSpacifyWork()));
                  },
                ),
                // ProfileMenuWidget(
                //   title: 'Availability',
                //   icon: Icons.event_available,
                //   onpress: () {},
                // ),
                ProfileMenuWidget(
                  title: 'My activities',
                  icon: Icons.history,
                  onpress: () {},
                ),
                const Divider(),
                ProfileMenuWidget(
                  title: 'Information',
                  icon: Icons.info_outline,
                  onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Information()));
                  },
                ),
                ProfileMenuWidget(
                  title: 'Logout',
                  textColor: kred,
                  icon: Icons.logout,
                  endIcon: false,
                  onpress: () {
                    service.signOutUser(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
