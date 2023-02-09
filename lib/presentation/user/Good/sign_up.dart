import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/user/Good/backend/auth.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error = '';
  TextEditingController kemail = TextEditingController();

  TextEditingController kpass = TextEditingController();

  TextEditingController kname = TextEditingController();

  TextEditingController kphone = TextEditingController();

  TextEditingController kpin = TextEditingController();

  AuthService auth = AuthService();

  final storeUser = FirebaseFirestore.instance;
  final _formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // String? name;
    // String? phone;
    // String? pin;
    // String? email;
    // String? password;

    final size = MediaQuery.of(context).size;
    // final size = MediaQuery.of(context).size;
    // final _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 238, 238),
          // gradient: kblackgd,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                width: size.width,
                height: size.width * 1.2,
                decoration: const BoxDecoration(
                  // color: kgold,
                  gradient: LinearGradient(colors: [
                    kgold,
                    Color.fromARGB(255, 245, 236, 154),
                    kgold
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      kheight20,
                      Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/workerr_gold.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      kheight20,
                      const Text(
                        'Create a new account',
                        style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontWeight: FontWeight.bold),
                      ),
                      kheight20,
                      Container(
                        width: 300,
                        height: 475,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: _formKeys,
                            child: Column(
                              children: [
                                const Center(
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      // textAlign: TextAlign.start,
                                      style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        // backgroundColor: kgold,
                                        color: kred,

                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        // decoration: TextDecoration.underline,
                                        // decorationThickness: 1.3,
                                        // decorationColor: kred,
                                      ),
                                    ),
                                  ),
                                ),
                                kheight,
                                TextFormField(
                                  controller: kname,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a name';
                                    } else if (value.length < 3) {
                                      return 'name must contan 3 letters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.center,
                                  // onChanged: (value) {
                                  //   name = value;
                                  //   // print(name);
                                  // },
                                  decoration: textDec(
                                      'Name', 'Enter a Name', Icons.person),
                                ),
                                kheight,
                                TextFormField(
                                  controller: kphone,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Enter a phone number';
                                  //   } else if (value.length < 10) {
                                  //     return 'phone number must contan 10 letters';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  // onChanged: (value) {
                                  //   phone = value;
                                  //   // print(phone);
                                  // },
                                  decoration: textDec(
                                      'Phone No',
                                      'Enter a Phone No (Optional)',
                                      Icons.phone_android),
                                ),
                                kheight,
                                TextFormField(
                                  controller: kpin,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Enter a pin code';
                                  //   } else if (value.length < 6) {
                                  //     return 'pin code must contan 6 letters';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  // onChanged: (value) {
                                  //   pin = value;
                                  //   // print(pin);
                                  // },
                                  decoration: textDec(
                                      'PIN Code',
                                      'Enter a PIN Code (Optional)',
                                      Icons.place_outlined),
                                ),
                                kheight,
                                TextFormField(
                                  controller: kemail,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a email';
                                    } else if (value.contains('@')) {
                                      return 'Enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  // onChanged: (value) {
                                  //   email = value;
                                  //   // print(email);
                                  // },
                                  decoration: textDec('Email', 'Enter a Email',
                                      Icons.email_outlined),
                                ),
                                kheight20,
                                TextFormField(
                                  controller: kpass,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a password';
                                    } else if (value.length < 6) {
                                      return 'Password must contan 6 letters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  // onChanged: (value) {
                                  //   password = value;
                                  //   // print(password);
                                  // },
                                  decoration: textDec('Password',
                                      'Enter a Password', Icons.fingerprint),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      kheight,
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKeys.currentState!.validate()) {
                            dynamic result = await auth.signUp(kemail.text,
                                kpass.text, kname.text, kpin.text, kphone.text);
                            if (result == null) {
                              setState(() {
                                error = 'Please Enter a valid email';
                              });
                            }
                          }
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // if (kname.text.isNotEmpty &&
                          //     kphone.text.isNotEmpty &&
                          //     kpin.text.isNotEmpty &&
                          //     kemail.text.isNotEmpty &&
                          //     kpass.text.isNotEmpty) {
                          //   prefs.setString('email', kemail.text);
                          //   storeUser
                          //       .collection("Users")
                          //       .doc()
                          //       .set({'uid': ""});

                          //   service.createUser(
                          //       context, kemail.text, kpass.text);
                          //   // FirebaseUser
                          // } else {
                          //   service.errorBox(context, 'Fields must be filled');
                          // }
                          // try {
                          //   final newUser = await _auth
                          //       .createUserWithEmailAndPassword(
                          //       email: email!, password: password!);
                          //   if (newUser != null) {
                          // if (_formKeys.currentState!.validate()) {
                          //   Navigator.of(context).pushNamedAndRemoveUntil(
                          //       'main', (route) => false);
                          // }
                          //   }
                          // } catch (e) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Invalid data")),
                          //   );
                          // }
                          // ;
                        },
                        child: Text("Register"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kred),
                          elevation: MaterialStateProperty.all(4.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 72, 71, 71),
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggle();
                              // Navigator.of(context).pushNamed('login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: kred,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
