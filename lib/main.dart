// import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/presentation/admin/screens/admin_main_screen.dart';
import 'package:workerr_app/presentation/admin/authentication/admin_login.dart';
import 'package:workerr_app/presentation/user/screens/authentication/login.dart';
import 'package:workerr_app/presentation/user/screens/authentication/reg2.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/register.dart';
// import 'package:workerr_app/presentation/user/screens/home/my%20works/screen_home.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';

// final _formKey = GlobalKey<FormState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp();
  // await initialization(null);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var email = prefs.getString('email');
  runApp(
    MaterialApp(
      title: 'Workerr',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        backgroundColor: kc60,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: kc60,
        primarySwatch: Colors.teal,
        backgroundColor: backgroundColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: email == null ? const Login() : const ScreenMain(),
      routes: {
        'login': ((ctx) => const Login()),
        'register': ((ctx) => const Register2()),
        'adminLogin': ((ctx) => const AdminLoginScreen()),
        'main': ((ctx) => const ScreenMain()),
        'adminMain': ((ctx) => const AdminScreenMain()),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future initialization(BuildContext? context) async {
  // await Future.delayed(const Duration(seconds: 2));
}
