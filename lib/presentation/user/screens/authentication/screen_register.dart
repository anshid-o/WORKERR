// import 'package:flutter/material.dart';
// import 'package:workerr_app/core/colors.dart';
// import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/authentication/screen_login.dart';
// import 'package:workerr_app/presentation/user/screens/screen_main.dart';

// // import 'package:firebase_auth/firebase_auth.dart';

// class ScreenRegister extends StatelessWidget {
//   const ScreenRegister({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     String? name;
//     String? phone;
//     String? pin;
//     String? email;
//     String? password;
//     final size = MediaQuery.of(context).size;
//     // final _auth = FirebaseAuth.instance;
//     return SafeArea(
//       child: Container(
//         decoration: BoxDecoration(
//           // color: kgold,
//           gradient: kblackgd,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   kheight30,
//                   Container(
//                     width: size.width,
//                     height: 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                             image: AssetImage('assets/workerr_gold.jpg'),
//                             fit: BoxFit.cover)),
//                   ),
//                   kheight30,
//                   Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: kgoldgd,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       height: 40,
//                       width: 200,
//                       child: const Center(
//                         child: Text(
//                           "Register",
//                           style: TextStyle(
//                               // fontStyle: FontStyle.italic,
//                               // backgroundColor: kgold,
//                               color: Colors.black,
//                               fontSize: 35,
//                               fontWeight: FontWeight.w900,
//                               decoration: TextDecoration.underline,
//                               decorationThickness: 1.3,
//                               decorationColor: kred),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kheight30,
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       name = value;
//                       print(name);
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a Name',
//                       hintStyle: TextStyle(color: Colors.white),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kgreen, width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   kheight20,
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       phone = value;
//                       print(phone);
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a Phone number',
//                       hintStyle: TextStyle(color: Colors.white),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kgreen, width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   kheight20,
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       pin = value;
//                       print(pin);
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your PIN Code',
//                       hintStyle: TextStyle(color: Colors.white),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kgreen, width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   kheight20,
//                   TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       email = value;
//                       print(email);
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a Email',
//                       hintStyle: TextStyle(color: Colors.white),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kgreen, width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   kheight20,
//                   TextFormField(
//                     obscureText: true,
//                     keyboardType: TextInputType.emailAddress,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       password = value;
//                       print(password);
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a Password',
//                       hintStyle: TextStyle(color: Colors.white),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kgreen, width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   kheight30,
//                   ElevatedButton(
//                     onPressed: () {
//                       // try {
//                       //   final newUser = await _auth
//                       //       .createUserWithEmailAndPassword(
//                       //       email: email!, password: password!);
//                       //   if (newUser != null) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ScreenMain()));
//                       //   }
//                       // } catch (e) {
//                       //   ScaffoldMessenger.of(context).showSnackBar(
//                       //     SnackBar(content: Text("Invalid data")),
//                       //   );
//                       // }
//                       // ;
//                     },
//                     child: Text("Register"),
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(kred),
//                       elevation: MaterialStateProperty.all(4.0),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kheight,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Already registred!!!',
//                         style: TextStyle(color: kgold),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ScreenLogin()));
//                         },
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                               color: kgold,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline,
//                               decorationColor: kred,
//                               decorationThickness: 1.5),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
