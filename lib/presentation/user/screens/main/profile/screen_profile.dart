// import 'dart:html';
// import 'dart:io';
import 'dart:io' as i;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/user/Good/backend/users.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/information.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/screen_report.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/settings.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/work_status.dart';
// import 'package:workerr_app/presentation/user/screens/home/profile/update_availability.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/update_profile.dart';
// import 'package:workerr_app/presentation/user/screens/screen_main.dart';
// import 'package:workerr_app/presentation/user/screens/home/profile/update_profile.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
// import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';
import 'package:workerr_app/presentation/user/widgets/profile_menu_widget.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  Service service = Service();
  bool fetching = true;
  XFile? file;
  final firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  String imageUrl = '';
  @override
  build(BuildContext context) {
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
        body: StreamBuilder<QuerySnapshot>(
          stream: firebase
              .collection("Users")
              .where("uid", isEqualTo: user.uid)
              .snapshots(),
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
                DocumentSnapshot document = snapshot.data!.docs[0];
                String name = document['name'];
                return snapshot.data!.docs.isNotEmpty
                    ? SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: document['imageUrl'] == ''
                                            ? Image.asset(
                                                'assets/persons/default.jpg',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                document['imageUrl'],
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: kc10),
                                      child: IconButton(
                                        onPressed: () async {
                                          await showOptionsDialog(context);
                                          // print(file!.path);
                                          if (file != null) {
                                            String uniqueFileName =
                                                DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();
                                            Reference referenceRoot =
                                                FirebaseStorage.instance.ref();
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
                                              if (imageUrl.isEmpty) {
                                                showDone(
                                                    context,
                                                    'Please upload an image',
                                                    Icons.error,
                                                    Colors.red);
                                              }
                                              firebase
                                                  .collection("Users")
                                                  .doc(user.uid)
                                                  .update(
                                                      {'imageUrl': imageUrl});
                                            } catch (e) {
                                              print('Error ' + e.toString());
                                            }
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kheight,
                              Text(name[0].toUpperCase() + name.substring(1),
                                  style: const TextStyle(
                                    color: kc60,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),

                              Text(document['email'],
                                  style: const TextStyle(
                                    color: kc60,
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
                                              builder: (ctx) =>
                                                  UpdateProfile()));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kc10),
                                      // elevation: MaterialStateProperty.all(4.0),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    child: document['status'] == 'C'
                                        ? const Text(
                                            'Update Profile',
                                            style: TextStyle(
                                                color: kc60,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            'Complete Profile',
                                            style: TextStyle(
                                                color: kc60,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                              ),
                              kheight,

                              kheight,
                              // Menu
                              ProfileMenuWidget(
                                title: 'Settings',
                                icon: CupertinoIcons.settings_solid,
                                onpress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingsPage(),
                                      ));
                                },
                              ),
                              ProfileMenuWidget(
                                title: 'Update Work',
                                icon: Icons.work,
                                onpress: () {
                                  document['status'] == 'C'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ScreenSpacifyWork(
                                                    district:
                                                        document['district'],
                                                    pincode: document['pin'],
                                                    name: document['name'],
                                                  )))
                                      : showDone(
                                          context,
                                          'You are not completed your Profile',
                                          Icons.warning,
                                          Colors.red);
                                },
                              ),
                              // ProfileMenuWidget(
                              //   isSwitch: true,
                              //   title: 'Availability',
                              //   icon: Icons.event_available,
                              //   onpress: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (ctx) => const UpdateAvailability()));
                              //   },
                              // ),
                              ProfileMenuWidget(
                                title: 'Report',
                                icon: Icons.report_problem_rounded,
                                onpress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => ScreenReport()));
                                },
                              ),
                              const Divider(),
                              ProfileMenuWidget(
                                title: 'Information',
                                icon: CupertinoIcons.info_circle_fill,
                                onpress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const Information()));
                                },
                              ),
                              ProfileMenuWidget(
                                title: 'Logout',
                                textColor: kred,
                                icon: Icons.logout,
                                endIcon: false,
                                onpress: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('email');
                                  service.signOutUser(context);
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kc60,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'You are not posted any works yet.',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: kc30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          kheight30,
                        ],
                      );
            }
          },
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
              )

              // SingleChildScrollView(
              //   child: ListBody(
              //     children: [
              //       GestureDetector(
              //         child: Text('Capture Image From Camera'),
              //         onTap: () async {
              // file = await imagePicker.pickImage(
              //     source: ImageSource.camera);
              // Navigator.pop(context);
              //         },
              //       ),
              //       Padding(padding: EdgeInsets.all(10)),
              //       GestureDetector(
              //         child: Text('Take Image From Gallery'),
              //         onTap: () async {
              //           file = await imagePicker.pickImage(
              //               source: ImageSource.gallery);
              //           Navigator.pop(context);
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              );
        });
  }
}
