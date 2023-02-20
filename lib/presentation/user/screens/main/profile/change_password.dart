import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final kname = TextEditingController();
  final ke = TextEditingController();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  // resetPassword({required String email}) async {
  //   await FirebaseAuth.instance
  //       .sendPasswordResetEmail(email: email);
  //       // .then((value) => _status = AuthStatus.successful)
  //       // .catchError(
  //       //     (e) => _status = AuthExceptionHandler.handleAuthException(e));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kc30,
      appBar: AppBar(
        // shadowColor: Colors.white,
        // bottomOpacity: 0,
        // foregroundColor: Colors.white,
        backgroundColor: kc30,

        title: const Text(
          'Change Password',
          style: TextStyle(
            color: kc60,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              kheight30,
              Form(
                  child: Column(
                children: [
                  MyTextForm(
                    textColor: kc30,
                    kt: ke,
                    name: 'Enter your email',
                    icon: Icons.mail,
                    type: TextInputType.emailAddress,
                  ),
                  ksize(x: 50),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser!
                              .updateEmail(ke.text);
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'email': ke.text});
                          Navigator.pop(context);
                          showDone(context, 'Email Changed', Icons.send,
                              Colors.green);
                        } catch (e) {
                          print(e.toString());
                        }

                        // showDone(context, 'Password changed Successfully',
                        //     Icons.done, Colors.green);
                        // firebase.collection("Users").doc(user.uid).update({
                        //   'password': kname.text,
                        // });

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const UpdateProfile()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kgold),
                        // elevation: MaterialStateProperty.all(4.0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
