import 'dart:async';
// import 'package:email_auth/utils/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';

class EmailVerificationScreen extends StatefulWidget {
  String name;
  String phone;
  String pin;
  EmailVerificationScreen(
      {Key? key, required this.name, required this.phone, required this.pin})
      : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // print('user not null');
        FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': widget.name,
          'phone': widget.phone,
          'place': widget.pin,
          'status': 'R',
          'imageUrl': '',
          'rating': 0,
          'count': 0
        });
        // print('store');
        var x = FirebaseAuth.instance.currentUser!.email;
        if (x != null) {
          prefs.setString('email', x);
        }
      }
      // TODO: implement your code after email verification
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registered successfully'),
        behavior: SnackBarBehavior.floating,
        width: 300,
      ));

      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const ScreenMain()));

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Check your Email',
                  style: TextStyle(
                      color: kc30, fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              kheight30,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email on  ${FirebaseAuth.instance.currentUser?.email}',
                    style: const TextStyle(
                        color: kc30, fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              kheight20,
              Center(
                  child: Lottie.asset(
                'assets/lottie/97952-loading-animation-blue.json',
                height: 100,
                width: 100,
              )),
              kheight,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    style: TextStyle(
                        color: kc30, fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Resend'),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
