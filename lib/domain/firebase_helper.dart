import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/domain/database.dart';
import 'package:workerr_app/presentation/user/Good/backend/users.dart';
import 'package:workerr_app/presentation/user/screens/authentication/login.dart';
import 'package:workerr_app/presentation/user/screens/main/home/works.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';

class Service {
  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;
  MyUser _userFromFirebaseUser(User? user) {
    if (user != null) {
      return MyUser(uid: user.uid);
    } else {
      return MyUser(uid: 'null');
    }
  }

  Future<Wusers Function(Map<String, dynamic> json)> getUserDetails(
      String uid) async {
    final snapshot =
        await storeUser.collection("Users").where('uid', isEqualTo: uid).get();
    final userksdata = snapshot.docs.map((e) => Wusers.fromJson).single;
    return userksdata;
  }

  Future<List<Wworks Function(Map<String, dynamic> json)>>
      getAllWorksDetails() async {
    final snapshot = await storeUser.collection("Works").get();
    final worksdata = snapshot.docs.map((e) => Wworks.fromJson).toList();
    return worksdata;
  }

  Stream<MyUser> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateUser(user, String name, String phone, String pin,
      String email, String password) async {
    if (pin.isEmpty) {
      pin = '673661';
    }
    if (phone.isEmpty) {
      phone = '';
    }
    await DatabaseService(uid: user.uid)
        .updateUsers(name, phone, '', '', pin, '', email, password, '', '');
  }

  // Future createUser(context, String email, String password, String name,
  //     String pin, String phone) async {
  //   try {
  //     UserCredential result = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     MyUser user = result.user as MyUser;
  //     await updateUser(user, name, phone, pin, email, password);
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (ctx) => const ScreenMain()));
  //   } catch (e) {
  //     errorBox(context, e);
  //   }
  // }
  //  Future signUp(String email, String password, String name, String pin,
  //     String phone) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;
  //     await updateUser(user, name, phone, pin, email, password);
  //     return _userFromFirebaseUser(user!);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  void createUser(context, email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        storeUser
            .collection("Users")
            .doc(user.uid)
            .set({'uid': user.uid, 'email': user.email});
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ScreenMain()));
      }
    } catch (e) {
      errorBox(context, e);
    }
  }

  void loginUser(context, email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ScreenMain()));
      });
    } catch (e) {
      errorBox(context, e);
    }
  }

  void signOutUser(context) async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } catch (e) {
      errorBox(context, e);
    }
  }

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
          );
        });
  }
}

class MyUser {
  final String uid;
  MyUser({required this.uid});
}
