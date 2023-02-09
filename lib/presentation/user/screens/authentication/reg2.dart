import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/domain/firebase_helper.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';
import 'package:workerr_app/presentation/user/widgets/loading.dart';

// import 'login.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class Register2 extends StatefulWidget {
  const Register2({Key? key}) : super(key: key);

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  TextEditingController kemail = TextEditingController();

  TextEditingController kpass = TextEditingController();

  TextEditingController kname = TextEditingController();

  TextEditingController kphone = TextEditingController();

  TextEditingController kpin = TextEditingController();
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;
  final storeUser = FirebaseFirestore.instance;
  Service service = Service();
  bool loading = false;

  final _formKeys = GlobalKey<FormState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                                      image:
                                          AssetImage('assets/workerr_gold.jpg'),
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
                                        decoration: textDec('Name',
                                            'Enter a Name', Icons.person),
                                      ),
                                      kheight,
                                      TextFormField(
                                        controller: kphone,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter a phone number';
                                          } else if (value.length < 10) {
                                            return 'phone number must contan 10 letters';
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.phone,
                                        textAlign: TextAlign.center,
                                        // onChanged: (value) {
                                        //   phone = value;
                                        //   // print(phone);
                                        // },
                                        decoration: textDec(
                                            'Phone No',
                                            'Enter a Phone Number',
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
                                            'Place',
                                            'Enter your Place',
                                            Icons.place_outlined),
                                      ),
                                      kheight,
                                      TextFormField(
                                        controller: kemail,
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
                                        // onChanged: (value) {
                                        //   email = value;
                                        //   // print(email);
                                        // },
                                        decoration: textDec(
                                            'Email',
                                            'Enter a Email',
                                            Icons.email_outlined),
                                      ),
                                      kheight20,
                                      TextFormField(
                                          controller: kpass,
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Enter a password';
                                          //   } else if (value.length < 6) {
                                          //     return 'Password must contan 6 letters';
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
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
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            kheight,
                            ElevatedButton(
                              onPressed: () async {
                                // print('button pressed');
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (kname.text.isNotEmpty &&
                                    kphone.text.isNotEmpty &&
                                    kpin.text.isNotEmpty &&
                                    kemail.text.isNotEmpty &&
                                    kpass.text.isNotEmpty) {
                                  // print('if1');
                                  try {
                                    // print('try loading true');
                                    setState(() {
                                      loading = true;
                                    });
                                    await auth.createUserWithEmailAndPassword(
                                        email: kemail.text,
                                        password: kpass.text);
                                    // print('tried to create');
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      // print('user not null');
                                      storeUser
                                          .collection("Users")
                                          .doc(user.uid)
                                          .set({
                                        'uid': user.uid,
                                        'email': user.email,
                                        'password': kpass.text,
                                        'name': kname.text,
                                        'phone': kphone.text,
                                        'place': kpin.text,
                                        'status': 'R',
                                        'imageUrl': ''
                                      });
                                      // print('store');
                                      prefs.setString('email', kemail.text);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const ScreenMain()));
                                      showDone(
                                          context,
                                          'Registered successfully',
                                          Icons.done,
                                          Colors.green);
                                      setState(() {
                                        loading = false;
                                      });
                                      // print('navigated');
                                    }
                                  } catch (e) {
                                    // print('catch');
                                    setState(() {
                                      loading = false;
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

                                  // FirebaseUser
                                } else {
                                  // print('else worked');
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
                                                  BorderRadius.circular(20.0)),
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
                              child: const Text("Register"),
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
                                    Navigator.of(context).pushNamed('login');
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
