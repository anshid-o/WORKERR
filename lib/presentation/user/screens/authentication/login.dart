// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/admin/authentication/admins.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/forgot_password.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/screen_login.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';
import 'package:workerr_app/presentation/user/widgets/loading.dart';
// import 'package:workerr_app/presentation/admin/screens/authentication/admin_login.dart';
// // import 'package:workerr_app/presentation/admin/authentication/admin_login.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/register.dart';

// import 'package:workerr_app/presentation/user/screens/screen_main.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController kemail = TextEditingController();
  bool isadmin = false;
  TextEditingController kpass = TextEditingController();
  double x = .32;
  //  Service service = Service();
  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;

  bool loading = false;
  List<Wadmins> adminList = [];
  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var radmins = records.docs
        .map((item) => Wadmins(
            email: item['email'],
            name: item['name'],
            password: item['password'],
            uid: item.id))
        .toList();

    setState(() {
      adminList = radmins;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String? email;
    // String? password;
    final size = MediaQuery.of(context).size;
    // final size = MediaQuery.of(context).size;
    // final _auth = FirebaseAuth.instance;
    return loading
        ? const Loading()
        : SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 238, 238),
                // gradient: kblackgd,
                // borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
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
                              InkWell(
                                onDoubleTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenMain(),
                                      ));
                                },
                                child: Container(
                                  width: size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/workerr_gold.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              kheight20,
                              const Text(
                                'Welcome Back',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 72, 71, 71),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              kheight,
                              Lottie.asset(
                                  'assets/lottie/office-worker-team-work-hello-office-waves.json',
                                  height: size.height * .185),
                              Container(
                                width: size.width * .8,
                                height: size.height * x,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        kheight,
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
                                        kheight20,
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: kemail,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !value.contains('@')) {
                                              return 'Enter an Email';
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.center,
                                          onChanged: (value) {
                                            // email = value;
                                            // print(email);
                                          },
                                          decoration: textDec(
                                              'Email',
                                              'Enter a Email',
                                              Icons.email_outlined),
                                        ),
                                        kheight20,
                                        TextFormField(
                                            controller: kpass,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter a password';
                                              } else if (value.length < 6) {
                                                return 'Password must contan 6 letters';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onFieldSubmitted: (value) async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final isValidForm = formKey
                                                  .currentState!
                                                  .validate();
                                              if (isValidForm) {
                                                if (kemail.text.isNotEmpty &&
                                                    kpass.text.isNotEmpty) {
                                                  // service.loginUser(context, kemail.text, kpass.text);
                                                  try {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    var records =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Admins')
                                                            .get();
                                                    mapRecords(records);
                                                    int i = 0;
                                                    while (
                                                        i < adminList.length) {
                                                      if (adminList[i].email ==
                                                          kemail.text) {
                                                        setState(() {
                                                          isadmin = true;
                                                          loading = false;
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    kc30,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0)),
                                                                title:
                                                                    const Text(
                                                                  'Error',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kc60),
                                                                ),
                                                                content:
                                                                    const Text(
                                                                  'An admin can\'t login as user !!',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kc60),
                                                                ),
                                                              );
                                                            });
                                                        break;
                                                      }
                                                      i = i + 1;
                                                    }
                                                    if (!isadmin) {
                                                      await auth
                                                          .signInWithEmailAndPassword(
                                                              email:
                                                                  kemail.text,
                                                              password:
                                                                  kpass.text);
                                                      final user = FirebaseAuth
                                                          .instance.currentUser;
                                                      if (user != null) {
                                                        prefs.setString('email',
                                                            kemail.text);

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    const ScreenMain()));
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      loading = false;
                                                    });

                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                kc30,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),
                                                            title: const Text(
                                                              'Error',
                                                              style: TextStyle(
                                                                  color: kc60),
                                                            ),
                                                            content: Text(
                                                                e.toString(),
                                                                style: const TextStyle(
                                                                    color:
                                                                        kc60)),
                                                          );
                                                        });
                                                  }
                                                } else {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor: kc30,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          title: const Text(
                                                            'Error',
                                                            style: TextStyle(
                                                                color: kc60),
                                                          ),
                                                          content: const Text(
                                                            'Fields must be filled',
                                                            style: TextStyle(
                                                                color: kc60),
                                                          ),
                                                        );
                                                      });
                                                }
                                              }
                                            },
                                            obscureText: _obscureText,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              // password = value;
                                              // print(password);
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter a Password',

                                              fillColor: Colors.black,
                                              // helperText: 'Hi',
                                              label: const Text(
                                                "Password",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(_obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureText =
                                                        !_obscureText;
                                                  });
                                                },
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.lock,
                                                color: Colors.black,
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              hintStyle: const TextStyle(
                                                  color: Colors.black),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 54, 9, 62),
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('adminLogin');
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
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final isValidForm =
                                      formKey.currentState!.validate();
                                  if (isValidForm) {
                                    if (kemail.text.isNotEmpty &&
                                        kpass.text.isNotEmpty) {
                                      // service.loginUser(context, kemail.text, kpass.text);
                                      try {
                                        setState(() {
                                          loading = true;
                                        });
                                        var records = await FirebaseFirestore
                                            .instance
                                            .collection('Admins')
                                            .get();
                                        mapRecords(records);
                                        int i = 0;
                                        while (i < adminList.length) {
                                          if (adminList[i].email ==
                                              kemail.text) {
                                            setState(() {
                                              isadmin = true;
                                              loading = false;
                                            });
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: kc30,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    title: const Text(
                                                      'Error',
                                                      style: TextStyle(
                                                          color: kc60),
                                                    ),
                                                    content: const Text(
                                                      'An admin can\'t login as user !!',
                                                      style: TextStyle(
                                                          color: kc60),
                                                    ),
                                                  );
                                                });
                                            break;
                                          }
                                          i = i + 1;
                                        }
                                        if (!isadmin) {
                                          await auth.signInWithEmailAndPassword(
                                              email: kemail.text,
                                              password: kpass.text);
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          if (user != null) {
                                            prefs.setString(
                                                'email', kemail.text);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        const ScreenMain()));
                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          setState(() {
                                            loading = false;
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                title: const Text("Alert!!"),
                                                content: const Text(
                                                    'No user found for that email.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (e.code == 'wrong-password') {
                                          setState(() {
                                            loading = false;
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                title: const Text("Alert!!"),
                                                content: const Text(
                                                    'Wrong password.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      "Forgot Password ?",
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      try {
                                                        Navigator.pop(context);
                                                        FirebaseAuth.instance
                                                            .sendPasswordResetEmail(
                                                                email: kemail
                                                                    .text);
                                                        showDone(
                                                            context,
                                                            'Link to password reset sent',
                                                            Icons.send,
                                                            Colors.green);
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } catch (e) {
                                        setState(() {
                                          loading = false;
                                        });

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: kc30,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                title: const Text(
                                                  'Error',
                                                  style: TextStyle(color: kc60),
                                                ),
                                                content: Text(e.toString(),
                                                    style: const TextStyle(
                                                        color: kc60)),
                                              );
                                            });
                                      }
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: kc30,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              title: const Text(
                                                'Error',
                                                style: TextStyle(color: kc60),
                                              ),
                                              content: const Text(
                                                'Fields must be filled',
                                                style: TextStyle(color: kc60),
                                              ),
                                            );
                                          });
                                    }
                                  } else {
                                    setState(() {
                                      x = .36;
                                    });
                                  }

                                  // if (_formKey.currentState!.validate()) {
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
                                  backgroundColor:
                                      MaterialStateProperty.all(kred),
                                  elevation: MaterialStateProperty.all(4.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                                  GestureDetector(
                                    onDoubleTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           LoginRegisterPage(),
                                      //     ));
                                    },
                                    child: const Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 72, 71, 71),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('register');
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
            ),
          );
  }
}
