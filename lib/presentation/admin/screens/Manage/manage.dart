import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/search_workers.dart';
import 'package:workerr_app/presentation/user/widgets/animated_list.dart';
import 'package:workerr_app/presentation/user/widgets/top_list_card2.dart';
import 'package:workerr_app/presentation/user/widgets/user_details.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  List<String> url = [];
  List<String> ids = [];
  List<Map<String, dynamic>> abc = [];

  getData(String id) async {}

  get() async {
    await FirebaseFirestore.instance
        .collection('Workers')
        .where('status', isNotEqualTo: 'O')
        .get()
        .then((value) => value.docs.forEach((element) async {
              var x = await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(element.id)
                  .get();
              url.add(x['imageUrl']);
              setState(() {
                abc.add(element.data());
                ids.add(element.id);
              });
            }));
  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: kc30,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Manage Users',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              // flexibleSpace: Container(
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('assets/wow.jpg'), fit: BoxFit.cover)
              //       // gradient: LinearGradient(colors: [
              //       //   Colors.green,
              //       //   Colors.red,
              //       // ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              //       ),
              // ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchWorkersPage(),
                          ));
                      // showSearch(
                      //     context: context, delegate: CustomSeachDeligate());
                    },
                    icon: const Icon(Icons.search))
              ],
              bottom: TabBar(tabs: [
                Tab(
                  // icon: Icon(
                  //   Icons.workspace_premium_sharp,s
                  //   size: 20,
                  // ),
                  // text: 'Top Workers',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.people_alt,
                            color: kc602,
                            size: 20,
                          ),
                          Text(
                            '  Users',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.work,
                            color: kc602,
                            size: 20,
                          ),
                          Text(
                            '  Workers',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: firebase
                  .collection("Users")
                  .where('status', isNotEqualTo: 'D')
                  .snapshots(),
              // .where({"status", "is", "Requested"}).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center();
                  default:
                    return snapshot.data!.docs.isNotEmpty
                        ? TabBarView(children: [
                            ListView.builder(
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                return document['uid'] !=
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? TempCard2(document: document)
                                    : Center();
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                            TempCard3(
                              abc: abc,
                              url: url,
                              ids: ids,
                            )
                          ])
                        : Padding(
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
                          );
                }
              },
            )),
      ),
    );
  }
}

class TempCard2 extends StatelessWidget {
  TempCard2({
    super.key,
    required this.document,
  });

  final DocumentSnapshot<Object?> document;
  TextEditingController kreview = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration:
            BoxDecoration(color: kc60, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: ExpansionTile(
            leading: document['imageUrl'] == ''
                ? const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/persons/default.jpg'),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(document['imageUrl']),
                  ),
            title: Text(
              document['name'],
              style: const TextStyle(
                  color: kc30, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              document['place'],
              style: const TextStyle(
                  color: kc30, fontSize: 17, fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              onPressed: () {
                String review = '';
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Alert !',
                        style: TextStyle(
                            color: kc30,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'Are you sure , you want to delete ${document['name']}',
                        style: const TextStyle(
                            color: kc30,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Specify Reason',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: TextFormField(
                                    controller: kreview,
                                    minLines: 3,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        label: const Text('Enter Reason')),
                                  ),
                                  actions: [
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green)),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(document.id)
                                              .update({
                                            'status': 'D',
                                            'reason': kreview.text
                                          });
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.done),
                                        label: const Text('Proceed')),
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // updateStatus(context);
                                        },
                                        icon: const Icon(Icons.close),
                                        label: const Text('Discard')),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.exit_to_app),
                          label: const Text('Cancel'),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.manage_accounts_outlined),
            ),
            children: [
              kheight,
              Text(
                document['phone'],
                style: const TextStyle(
                    color: kc30, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                document['email'],
                style: const TextStyle(
                    color: kc30, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TempCard3 extends StatefulWidget {
  List<String> url;
  List<String> ids;
  List<Map<String, dynamic>> abc;
  TempCard3({
    required this.ids,
    required this.abc,
    required this.url,
    super.key,
  });

  @override
  State<TempCard3> createState() => _TempCard3State();
}

class _TempCard3State extends State<TempCard3> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var document = widget.abc[index];

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: kc60, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: ExpansionTile(
                leading: widget.url == ''
                    ? const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/persons/default.jpg'),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.url[index]),
                      ),
                title: Text(
                  document['name'],
                  style: const TextStyle(
                      color: kc30, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  document['job'],
                  style: const TextStyle(
                      color: kc30, fontSize: 17, fontWeight: FontWeight.w400),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Alert !',
                            style: TextStyle(
                                color: kc30,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Are you sure , you want to delete ${document['name']}',
                            style: const TextStyle(
                                color: kc30,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Workers')
                                    .doc(widget.ids[index])
                                    .update({'status': 'O'});
                                setState(() {
                                  widget.abc.remove(widget.abc[index]);
                                  widget.url.remove(widget.url[index]);
                                });
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete'),
                            ),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.exit_to_app),
                              label: const Text('Cancel'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.manage_accounts_outlined),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: widget.abc.length,
    );
  }
}

class TabBarRow extends StatelessWidget {
  String name;
  IconData icon;
  Color color;

  TabBarRow({
    Key? key,
    required this.name,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          ksize(y: 3.5),
          Text(name),
        ],
      ),
    );
  }
}
