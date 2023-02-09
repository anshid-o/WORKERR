import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final kname = TextEditingController();
  final kphone = TextEditingController();
  final kage = TextEditingController();
  final kplace = TextEditingController();
  final kpin = TextEditingController();
  final kdist = TextEditingController();
  XFile? file;
  String imageUrl = '';
  // late String _age;
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kc30,
      appBar: AppBar(
        // shadowColor: Colors.white,
        // bottomOpacity: 0,
        // foregroundColor: Colors.white,
        backgroundColor: kc30.withGreen(18),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: kc60,
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
              color: kc60,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebase
            .collection("Users")
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        // .where({"status", "is", "Requested"}).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  value: 60,
                  backgroundColor: kc60,
                ),
              );
            default:
              DocumentSnapshot document = snapshot.data!.docs[0];
              return snapshot.data!.docs.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: document['imageUrl'] == ''
                                          ? Image.asset(
                                              'assets/persons/default.jpg',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              document['imageUrl'])),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: kc60),
                                    child: IconButton(
                                      onPressed: () async {
                                        await showOptionsDialog(context);
                                        // print(file!.path);
                                        if (file != null) {
                                          String uniqueFileName = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImages =
                                              referenceRoot
                                                  .child('Usersimages');
                                          Reference referenceImageToUpload =
                                              referenceDirImages
                                                  .child(uniqueFileName);
                                          i.File f = i.File(file!.path);
                                          try {
                                            await referenceImageToUpload
                                                .putFile(f);
                                            imageUrl =
                                                await referenceImageToUpload
                                                    .getDownloadURL();
                                            if (imageUrl.isEmpty) {
                                              showDone(
                                                  context,
                                                  'Please upload an image',
                                                  Icons.error,
                                                  Colors.red);
                                            }
                                            firebase
                                                .collection("Users")
                                                .doc(user.uid)
                                                .update({'imageUrl': imageUrl});
                                          } catch (e) {
                                            print('Error ' + e.toString());
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kheight,
                            Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  // initialValue: document['name'],
                                  controller: kname,
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  style: const TextStyle(color: kc60),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: kc60.withOpacity(.2),
                                    label: const Text(
                                      'Full Name',
                                      style: TextStyle(color: kc10),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: kc10,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kc10, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    hintStyle: const TextStyle(color: kc10),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kc10, width: 3.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                // MyTextForm(
                                //   kt: kname,
                                //   name: 'Full Name',
                                //   icon: Icons.person,
                                //   type: TextInputType.name,
                                // ),
                                Row(
                                  children: [
                                    Radio(
                                        overlayColor:
                                            MaterialStateProperty.all(kgold),
                                        value: 1,
                                        groupValue: _value,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                    const Text(
                                      'Male',
                                      style: TextStyle(
                                          color: kc10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kwidth,
                                    Radio(
                                        overlayColor:
                                            MaterialStateProperty.all(kgold),
                                        value: 2,
                                        groupValue: _value,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                    const Text(
                                      'Female',
                                      style: TextStyle(
                                          color: kc10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kwidth,
                                    Radio(
                                        overlayColor:
                                            MaterialStateProperty.all(kgold),
                                        value: 3,
                                        groupValue: _value,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                    const Text(
                                      'Others',
                                      style: TextStyle(
                                          color: kc10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                MyTextForm(
                                  kt: kage,
                                  name: 'Age',
                                  icon: Icons.numbers,
                                  type: TextInputType.number,
                                ),
                                kheight20,
                                MyTextForm(
                                  kt: kphone,
                                  name: 'Phone No',
                                  icon: Icons.phone_android,
                                  type: TextInputType.phone,
                                ),
                                kheight20,
                                MyTextForm(
                                  kt: kplace,
                                  name: 'Place',
                                  icon: Icons.location_city_rounded,
                                  type: TextInputType.streetAddress,
                                ),
                                kheight20,
                                MyTextForm(
                                  kt: kpin,
                                  name: 'PIN Code',
                                  icon: Icons.local_post_office,
                                  type: TextInputType.number,
                                ),
                                kheight20,
                                MyTextForm(
                                  kt: kdist,
                                  name: 'District',
                                  icon: Icons.place,
                                  type: TextInputType.streetAddress,
                                ),
                                kheight,

                                // For Age
                                // DropdownButton(items: () {
                                //   return DropdownMenuItem(
                                //     child: Text('Hi'),
                                //   );
                                // }, onChanged: (selValue) {
                                //   _age = selValue.toString();
                                // }),
                                // remining

                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (kage.text.isEmpty ||
                                          kdist.text.isEmpty ||
                                          kname.text.isEmpty ||
                                          kphone.text.isEmpty ||
                                          kpin.text.isEmpty ||
                                          kplace.text.isEmpty) {
                                        showDone(
                                            context,
                                            'Please fill all fields',
                                            Icons.warning,
                                            Colors.red);
                                      } else {
                                        var g = _value == 1
                                            ? 'Male'
                                            : _value == 2
                                                ? 'Female'
                                                : 'Other';
                                        firebase
                                            .collection("Users")
                                            .doc(user.uid)
                                            .update({
                                          'age': kage.text,
                                          'gender': g,
                                          'place': kplace.text.trim(),
                                          'district': kdist.text.trim(),
                                          'name': kname.text.trim(),
                                          'phone': kphone.text,
                                          'pin': kpin.text,
                                          'status': 'C'
                                        });
                                        Navigator.pop(context);
                                        showDone(
                                            context,
                                            'Profile Upadated Successfully',
                                            Icons.done,
                                            Colors.green);
                                      }

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => const UpdateProfile()));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kc60),
                                      // elevation: MaterialStateProperty.all(4.0),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Update',
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
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kc60,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'You are not posted any works yet.',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: kc30,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        kheight30,
                      ],
                    );
          }
        },
      ),
    );
  }

  Future<void> showOptionsDialog(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
              title: const Text(
                'Profle photo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: size.width * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera_alt),
                              ),
                            ),
                            kheight,
                            const Text('Camera')
                          ],
                        ),
                        kwidth,
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                              ),
                            ),
                            kheight,
                            const Text('Gallery')
                          ],
                        ),
                        kwidth,
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () async {
                                  file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.man),
                              ),
                            ),
                            kheight,
                            const Text('Avatar')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )

              // SingleChildScrollView(
              //   child: ListBody(
              //     children: [
              //       GestureDetector(
              //         child: Text('Capture Image From Camera'),
              //         onTap: () async {
              // file = await imagePicker.pickImage(
              //     source: ImageSource.camera);
              // Navigator.pop(context);
              //         },
              //       ),
              //       Padding(padding: EdgeInsets.all(10)),
              //       GestureDetector(
              //         child: Text('Take Image From Gallery'),
              //         onTap: () async {
              //           file = await imagePicker.pickImage(
              //               source: ImageSource.gallery);
              //           Navigator.pop(context);
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              );
        });
  }
}
