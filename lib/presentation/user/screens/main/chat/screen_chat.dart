import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

// import 'package:workerr_app/presentation/user/widgets/chat_card.dart';
import 'package:workerr_app/presentation/user/widgets/chat_card2.dart';
// import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/screens/my_tabbed_appbar.dart';

class ScreenChat extends StatefulWidget {
  ScreenChat({Key? key}) : super(key: key);

  @override
  State<ScreenChat> createState() => _ScreenChatState();
}

class _ScreenChatState extends State<ScreenChat> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  List<String> chatIds = [];

  getData() async {
    var a = await firebase.collection("Messages").get();

    a.docs.forEach((element) {
      if (element['to'] == user!.uid) {
        if (mounted && !chatIds.contains(element['from'])) {
          setState(() {
            chatIds.add(element['from']);
          });
        }
      }
    });
    a.docs.forEach((element) {
      if (element['from'] == user!.uid) {
        if (mounted && !chatIds.contains(element['to'])) {
          setState(() {
            chatIds.add(element['to']);
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: kc30,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: AppBar(
              backgroundColor: kc30.withGreen(18),
              automaticallyImplyLeading: false,
              title: const Text(
                'Messages',
                style: TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  tooltip: 'Top Workers',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyTabbedAppBar(),
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.person_3_fill,
                    color: kc10,
                    size: 30,
                    shadows: kshadow2,
                  ),
                ),
                kwidth
              ],
            ),
          ),
          body: chatIds.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ChatCard2(uid: chatIds[index], index: index);
                  },
                  itemCount: chatIds.length,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/lottie/not-found.json'),
                        Container(
                          height: size.height * .15,
                          decoration: BoxDecoration(
                              color: kc60,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'No messsages found in your inbox, yet !',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: kc30,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
