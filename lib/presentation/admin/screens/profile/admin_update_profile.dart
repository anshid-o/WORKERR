import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class AdminProfileUpdate extends StatelessWidget {
  AdminProfileUpdate({Key? key}) : super(key: key);

  final kname = TextEditingController();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        // bottomOpacity: 0,
        // foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(children: const [
          kwidth20,
          kwidth20,
          kwidth30,
          Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                width: 120,
                height: 120,
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 120,
                  color: Color.fromARGB(255, 4, 16, 79),
                ),
              ),
              kheight30,
              Form(
                  child: Column(
                children: [
                  MyTextForm(
                    textColor: kc30,
                    kt: kname,
                    name: 'Full Name',
                    icon: Icons.person,
                    type: TextInputType.name,
                  ),
                  ksize(x: 50),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (kname.text.isEmpty) {
                          showDone(context, 'Please fill all fields',
                              Icons.warning, Colors.red);
                        } else {
                          firebase.collection("Users").doc(user.uid).update({
                            'name': kname.text,
                          });
                          Navigator.pop(context);
                          showDone(context, 'Profile Upadated Successfully',
                              Icons.done, Colors.green);
                        }
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
                        'Edit Profile',
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
