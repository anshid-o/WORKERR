import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/main/home/screen_home.dart';
import 'package:workerr_app/presentation/user/screens/main/home/show_post.dart';
import 'package:workerr_app/presentation/user/screens/main/home/show_requests.dart';
import 'package:workerr_app/presentation/user/screens/main/home/user_page.dart';
import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';

class MyNavigationDrawer extends StatelessWidget {
  MyNavigationDrawer({
    super.key,
  });
  final firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
            String name = document['name'];
            ImageProvider image = document['imageUrl'] == ''
                ? const AssetImage('assets/persons/default.jpg')
                : NetworkImage(document['imageUrl']) as ImageProvider;
            return snapshot.data!.docs.isNotEmpty
                ? Drawer(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Ink(
                            width: double.infinity,
                            color: kc10.shade300,
                            child: InkWell(
                              splashColor: kc30,
                              onTap: () {
                                Navigator.pop(context);
                                for (int i = 0; i < 1000; i++) {}
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserPage(
                                        img: image,
                                        name: document['name'],
                                      ),
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 24 + MediaQuery.of(context).padding.top,
                                  // bottom: 24,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: document['imageUrl'] == ''
                                              ? Image.asset(
                                                  'assets/persons/default.jpg',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  document['imageUrl'],
                                                  fit: BoxFit.cover,
                                                )),
                                    ),
                                    Text(
                                        name[0].toUpperCase() +
                                            name.substring(1),
                                        style: const TextStyle(
                                          color: kc30,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      document['email'],
                                      style: const TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    kheight20
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(24),
                            child: Wrap(
                              runSpacing: 16,
                              children: [
                                // const Divider(
                                //   color: Colors.grey,
                                // ),

                                ListTile(
                                  leading: const Icon(
                                    Icons.work_history_outlined,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowRequest(),
                                      ),
                                    );
                                  },
                                  title: const Text(
                                    'My requests',
                                    style: TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.work,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowPost(),
                                      ),
                                    );
                                  },
                                  title: const Text(
                                    'My posts',
                                    style: TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    CupertinoIcons.time_solid,
                                    size: 30,
                                  ),
                                  onTap: () {},
                                  title: const Text(
                                    'My works',
                                    style: TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    CupertinoIcons.person_3_fill,
                                    size: 35,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyTabbedAppBar(),
                                      ),
                                    );
                                  },
                                  title: const Text(
                                    'Top Workers',
                                    style: TextStyle(
                                        color: kc30,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}