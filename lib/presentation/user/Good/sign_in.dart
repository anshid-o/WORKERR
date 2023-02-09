import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/user/Good/backend/auth.dart';
// import 'package:workerr_app/presentation/admin/screens/authentication/admin_login.dart';
// // import 'package:workerr_app/presentation/admin/authentication/admin_login.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/register.dart';

// import 'package:workerr_app/presentation/user/screens/screen_main.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String error = '';
  TextEditingController kemail = TextEditingController();

  TextEditingController kpass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // String? email;
    // String? password;
    final size = MediaQuery.of(context).size;
    // final size = MediaQuery.of(context).size;
    //  final _auth = FirebaseAuth.instance;
    AuthService auth = AuthService();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 238, 238),
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
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      kheight30,
                      Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/workerr_gold.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      kheight30,
                      kheight30,
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                            color: Color.fromARGB(255, 72, 71, 71),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      kheight30,
                      kheight30,
                      Container(
                        width: 300,
                        height: 310,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                kheight20,
                                const Center(
                                  child: Center(
                                    child: Text(
                                      "Login",
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
                                kheight30,
                                TextFormField(
                                  controller: kemail,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter an Email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    // email = value;
                                    // print(email);
                                  },
                                  decoration: textDec('Email', 'Enter a Email',
                                      Icons.email_outlined),
                                ),
                                kheight30,
                                kheight,
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
                                  onChanged: (value) {
                                    // password = value;
                                    // print(password);
                                  },
                                  decoration: textDec('Password',
                                      'Enter a Password', Icons.fingerprint),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('adminLogin');
                              },
                              child: const Text(
                                'Login as Admin',
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // if (kemail.text.isNotEmpty && kpass.text.isNotEmpty) {
                          //   prefs.setString('email', kemail.text);
                          //   service.loginUser(context, kemail.text, kpass.text);
                          // } else {
                          //   service.errorBox(context, 'Fields must be filled');
                          // }
                          if (_formKey.currentState!.validate()) {
                            dynamic result =
                                await auth.signIn(kemail.text, kpass.text);
                            if (result == null) {
                              setState(() {
                                error = 'Please Enter a valid email';
                              });
                            }
                          }
                          // try {
                          //   final newUser = await _auth
                          //       .createUserWithEmailAndPassword(
                          //       email: email!, password: password!);
                          //   if (newUser != null) {

                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     'main', (route) => false);

                          // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                          // }
                          //   }
                          // } catch (e) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Invalid data")),
                          //   );
                          // }
                          // ;
                        },
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
                        child: const Text("Login"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 72, 71, 71),
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed('register');
                              widget.toggle();
                            },
                            child: const Text(
                              "Register",
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
