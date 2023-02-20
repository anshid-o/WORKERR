import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/presentation/user/screens/main/workers_list.dart';

class MyAnimatedList extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> myList;
  const MyAnimatedList({Key? key, required this.myList}) : super(key: key);

  @override
  State<MyAnimatedList> createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  // List<FavWorkers> items = List.from(favWorkers);
  // final listKey = GlobalKey<AnimatedListState>();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  List<String> workers = [];
  List<String> workersId = [];
  List<String> workerWId = [];
  int count = -1;
  getData() async {
    await firebase
        .collection("Favorites")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: true)
        .orderBy('time', descending: true)
        .get()
        .then((querySnapshot) {
      final names = querySnapshot.docs
          .map((document) => document.data()['name'].toString())
          .toList();

      final wids = querySnapshot.docs
          .map((document) => document.data()['wid'].toString())
          .toList();
      final ids = querySnapshot.docs.map((document) => document.id).toList();
      if (mounted) {
        setState(() {
          workerWId = wids;
          workersId = ids;
          workers = names;
        });
      }
    });
    final a = await FirebaseFirestore.instance.collection("Favorites").get();
    if (mounted) {
      for (var element in a.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          setState(() {
            count = 1;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return count == 1
        ? ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              return StreamBuilder<QuerySnapshot>(
                stream: firebase
                    .collection("Users")
                    .where("uid", isEqualTo: workerWId[index])
                    .snapshots(),
                // .where({"status", "is", "Requested"}).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                          // child: CircularProgressIndicator(
                          //   value: 60,
                          //   backgroundColor: kc60,
                          // ),
                          );
                    default:
                      DocumentSnapshot document = snapshot.data!.docs[0];
                      ImageProvider image = document['imageUrl'] == ''
                          ? const AssetImage('assets/persons/default.jpg')
                          : NetworkImage(document['imageUrl']) as ImageProvider;
                      return snapshot.data!.docs.isNotEmpty
                          ? Dismissible(
                              key: Key(workers[index]),
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: Text(
                                        'Are you sure you want delete ${document['name']} from your favourute list ?'),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          firebase
                                              .collection('Favorites')
                                              .doc(workersId[index])
                                              .delete();
                                          setState(() {
                                            workers.removeAt(index);
                                          });
                                          Navigator.pop(context);
                                          showDone(context, 'Deleted',
                                              Icons.delete, Colors.red);
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              background: Container(color: Colors.red),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: kc602,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      title: Text(
                                        workers[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        document['place'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: kc30,
                                        backgroundImage: image,
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            firebase
                                                .collection('Favorites')
                                                .doc(workersId[index])
                                                .delete();
                                            setState(() {
                                              workers.removeAt(index);
                                            });
                                            showDone(context, 'Deleted',
                                                Icons.delete, Colors.red);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    )),
                              ))
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 100, 30, 0),
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
                            );
                  }
                },
              );

              //    AnimatedList(
              //     key: listKey,
              //     itemBuilder: ((context, index, animation) => items.isNotEmpty
              //         ?

              //          ListItemWidget(
              //             item: items[index],
              //             animation: animation,
              //             onClicked: () => removeItem(index))
              //         : const Padding(
              //             padding: EdgeInsets.only(top: 30),
              //             child: Center(
              //                 child: Text(
              //               'Not has Favorite workers',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold),
              //             )),
              //           )),
              //     initialItemCount: items.isNotEmpty ? items.length : 1,
              //   );
              // }

              // void removeItem(int index) {
              //   final removedItem = items[index];
              //   items.removeAt(index);
              //   listKey.currentState!.removeItem(
              //       index,
              //       (context, animation) => ListItemWidget(
              //           item: removedItem, animation: animation, onClicked: () {}),
              //       duration: const Duration(milliseconds: 600));
              //   setState(() {
              //     favWorkers.removeAt(index);
              //   });
            })
        : Center(
            child: Lottie.asset('assets/lottie/nohistory.json', repeat: false),
          );

// void insertItem(String name) {
//   final newIndex = 1;
//   final newItem = FavWorkers(name: name, url: 'assets/3.jpj');
//   items.insert(newIndex, newItem);

//   listKey.currentState!
//       .insertItem(newIndex, duration: Duration(milliseconds: 600));
// }
  }
}
