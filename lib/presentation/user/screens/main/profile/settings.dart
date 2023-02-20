import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/authentication/login.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/change_password.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/screen_feedback.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kc30,
      appBar: AppBar(
        // shadowColor: Colors.white,
        // bottomOpacity: 0,
        // foregroundColor: Colors.white,
        backgroundColor: kc30.withGreen(18),

        title: const Text(
          'Settings',
          style: TextStyle(
            color: kc60,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () async {
                const to = 'anshidkoolimad@gmail.com';
                const subject = 'Contact to Workerr Group';
                const message =
                    'Hello\tWorkerr\tTeam,\n\nCheck\tout\tthis\temail\tthat\tsented\tto\tcontact\tto\tworkerr\tgroup.';
                final ux = Uri(
                    scheme: 'mailto',
                    path: to,
                    queryParameters: {'subject': subject, 'body': message});
                String url = ux.toString();
                if (await canLaunch(url)) {
                  await launch(
                    url,
                  );
                } else {
                  print('Could not launch $url');
                }
              },
              title: const Text(
                'Help Center',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                Icons.help,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Security notifications',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                CupertinoIcons.shield_lefthalf_fill,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ));
              },
              title: const Text(
                'Change email',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                try {
                  var x = FirebaseAuth.instance.currentUser!.email;
                  if (x != null) {
                    FirebaseAuth.instance.sendPasswordResetEmail(email: x);
                    showDone(context, 'Link to password reset sent', Icons.send,
                        Colors.green);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              title: const Text(
                'Change Password',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                Icons.change_circle,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Request account info',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                CupertinoIcons.doc,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                try {
                  var x = FirebaseAuth.instance.currentUser!.email;
                  if (x != null) {
                    FirebaseAuth.instance.currentUser!.delete();
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc('${FirebaseAuth.instance.currentUser!.uid}')
                        .delete();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              title: const Text(
                'Delete my account',
                style: TextStyle(color: kc60),
              ),
              leading: const Icon(
                CupertinoIcons.delete,
                color: Colors.grey,
              ),
            ),
            kheight30,
            kheight30,
            Center(
              child: Lottie.asset(
                  'assets/lottie/free-icon-setting-4558279.json',
                  height: 250),
            ),
          ],
        ),
      ),
    );
  }
}
