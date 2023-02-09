// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/chat/widgets/show_message.dart';
// import 'package:workerr_app/presentation/user/screens/home/chat/widgets/message_recieved.dart';
// import 'package:workerr_app/presentation/user/screens/home/chat/widgets/message_sent.dart';
// import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

List<String> sentMessages = ['Hello'];
List<String> recievedMessages = [];
bool c = true;

class ChatScreenChild extends StatelessWidget {
  String name;
  ChatScreenChild({Key? key, required this.name}) : super(key: key);

  TextEditingController msg = TextEditingController();
  // Service service = Service();
  // final storeMessage = FirebaseFirestore.instance;
  // final auth = FirebaseAuth.instance;
  // getCurrentUser();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.white,
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
          title: Row(children: [
            const CircleAvatar(
              radius: 20,
              // backgroundColor: kblue2,
              backgroundImage: AssetImage('assets/mine.jpg'),
            ),
            kwidth,
            Text(
              name,
              style: const TextStyle(
                color: kc60,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          actions: [
            IconButton(
              onPressed: () {},
              splashColor: Colors.transparent,
              icon: const Icon(
                CupertinoIcons.phone_fill_arrow_up_right,
                color: kc10,
              ),
            ),
            kwidth,
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 238, 225, 225),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Text(
                    //   'message',
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    Container(
                      color: const Color.fromARGB(255, 238, 225, 225),
                      height: size.height - 130,
                      child: const SingleChildScrollView(
                        physics: ScrollPhysics(),
                        reverse: true,
                        child: ShowMessages(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey,
                              )),
                          Expanded(
                              child: TextFormField(
                            controller: msg,
                            onFieldSubmitted: (value) {
                              if (msg.text.isNotEmpty) {
                                sentMessages.add(msg.text.trim());
                                // const ShowMessages();
                                // storeMessage.collection("Messages").doc().set({
                                //   "message":msg.text.trim(),
                                //   "user":loginUser.email.toString(),
                                //   "time":DateTime.now(),
                                // });
                                msg.clear();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Message...',
                            ),
                          )),
                          IconButton(
                            onPressed: () {
                              if (msg.text.isNotEmpty) {
                                sentMessages.add(msg.text.trim());
                                // ShowMessages();
                                // storeMessage.collection("Messages").doc().set({
                                //   "message":msg.text.trim(),
                                //   "user":loginUser.email.toString(),
                                //   "time":DateTime.now(),
                                // });
                                msg.clear();
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.teal,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
