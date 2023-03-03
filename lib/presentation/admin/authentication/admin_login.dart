import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

import 'package:workerr_app/presentation/admin/authentication/admins.dart';
import 'package:workerr_app/presentation/user/widgets/loading.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController kemail = TextEditingController();
  bool isloading = false;
  bool _obscureText = true;
  TextEditingController kpass = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey3 = GlobalKey<FormState>();
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
    final size = MediaQuery.of(context).size;
    return isloading
        ? const Loading()
        : SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 238, 238),
                // gradient: kblackgd,
                // borderRadius: BorderRadius.circular(10),
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
                            InkWell(
                              onDoubleTap: () {
                                Navigator.pushNamed(context, 'adminMain');
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
                            Form(
                              key: _formKey3,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
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
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter a email';
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textAlign: TextAlign.center,
                                        controller: kemail,
                                        decoration: textDec(
                                            'Email',
                                            'Enter a Email',
                                            Icons.email_outlined),
                                      ),
                                      kheight30,
                                      kheight,
                                      TextFormField(
                                          onFieldSubmitted: (value) async {
                                            setState(() {
                                              isloading = true;
                                            });
                                            var records =
                                                await FirebaseFirestore.instance
                                                    .collection('Admins')
                                                    .get();
                                            mapRecords(records);
                                            int i = 0;
                                            try {
                                              while (adminList[i].email !=
                                                      kemail.text &&
                                                  adminList[i].password !=
                                                      kpass.text &&
                                                  i <= adminList.length) {
                                                i = i + 1;
                                              }
                                              if (i <= adminList.length) {
                                                await auth
                                                    .signInWithEmailAndPassword(
                                                        email: kemail.text,
                                                        password: kpass.text);
                                                setState(() {
                                                  isloading = false;
                                                });
                                                Navigator.of(context)
                                                    .pushNamed('adminMain');
                                              } else {
                                                setState(() {
                                                  isloading = false;
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const AlertDialog(
                                                        title: Text('Error'),
                                                        content: Text(
                                                            'Enter valid email & password'),
                                                      );
                                                    });
                                              }
                                            } on FirebaseAuthException catch (e) {
                                              if (e.code == 'wrong-password') {
                                                setState(() {
                                                  isloading = false;
                                                });
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      title:
                                                          const Text("Alert!!"),
                                                      content: const Text(
                                                          'Wrong password.'),
                                                    );
                                                  },
                                                );
                                              }
                                            } catch (e) {
                                              setState(() {
                                                isloading = false;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Error'),
                                                      content:
                                                          Text(e.toString()),
                                                    );
                                                  });
                                            }
                                          },
                                          obscureText: _obscureText,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.center,
                                          controller: kpass,
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
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
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
                                          )

                                          //  textDec(
                                          //     'Password',
                                          //     'Enter a Password',
                                          //     Icons.fingerprint),
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Login as User',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isloading = true;
                                });
                                var records = await FirebaseFirestore.instance
                                    .collection('Admins')
                                    .get();
                                mapRecords(records);
                                int i = 0;
                                try {
                                  while (adminList[i].email != kemail.text &&
                                      adminList[i].password != kpass.text &&
                                      i <= adminList.length) {
                                    i = i + 1;
                                  }
                                  if (i <= adminList.length) {
                                    await auth.signInWithEmailAndPassword(
                                        email: kemail.text,
                                        password: kpass.text);
                                    Navigator.of(context)
                                        .pushNamed('adminMain');
                                  } else {
                                    setState(() {
                                      isloading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'Enter valid email & password'),
                                          );
                                        });
                                  }
                                } catch (e) {
                                  setState(() {
                                    isloading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text(e.toString()),
                                        );
                                      });
                                }
                                // try {
                                //   final newUser = await _auth
                                //       .createUserWithEmailAndPassword(
                                //       email: email!, password: password!);
                                //   if (newUser != null) {

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
