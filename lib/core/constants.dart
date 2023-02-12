import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';

const kheight = SizedBox(height: 10);
const kheight20 = SizedBox(height: 20);
const kheight30 = SizedBox(height: 30);
const kwidth = SizedBox(width: 10);
const kwidth20 = SizedBox(width: 20);
const kwidth30 = SizedBox(width: 30);
ksize({double x = 0, double y = 0}) {
  return SizedBox(
    height: x,
    width: y,
  );
}

const kshadow = [
  Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 6)
];

const kshadow2 = [
  Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 5)
];

textDec(String name, String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,

    fillColor: Colors.black,
    // helperText: 'Hi',
    label: Text(
      name,
      style: TextStyle(color: Colors.black),
    ),
    prefixIcon: Icon(
      icon,
      color: Colors.black,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    hintStyle: const TextStyle(color: Colors.black),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 54, 9, 62), width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  );
}

void showDone(BuildContext ctx, String name, IconData icon, Color c) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        kwidth,
        Icon(
          icon,
          color: c,
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  ));
}

const ktextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

class CustomSeachDeligate extends SearchDelegate {
  List<String> searchTerms = [
    'Anshid',
    'Anas',
    'Abu',
    'Abid',
    'Adil',
    'Althaf',
    'Faheem',
    'Faris',
    'Faris P',
    'Nijas',
    'Yaseen',
    'Mishal',
    'Junaid',
    'Hisham'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    // throw UnimplementedError();
    return [
      query == ''
          ? IconButton(
              onPressed: () {
                query = '';
              },
              icon: Icon(Icons.clear),
            )
          : IconButton(
              onPressed: () {
                close(context, null);
              },
              icon: Icon(Icons.search)),
      if (query != '')
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> matchQuery = [];
    for (var x in searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: const Icon(
            Icons.restore_outlined,
            color: Colors.grey,
          ),
          onTap: () {
            query = result;
          },
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var x in searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: const Icon(
            Icons.restore_outlined,
            color: Colors.grey,
          ),
          // trailing: IconButton(
          //   onPressed: () {
          //     searchTerms.removeAt(index);
          //   },
          //   icon: Icon(Icons.delete)),
          onTap: () {
            query = result;
          },
          title: Text(result),
        );
      },
    );
  }
}

Future<dynamic> myRemiderMessage(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: const Text('Remider'),
        contentPadding: const EdgeInsets.all(20),
        content: const Text('Are you sure, you want to update the status ?'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done),
              label: const Text('Yes')),
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                // updateStatus(context);
              },
              icon: const Icon(Icons.close),
              label: const Text('No')),
        ],
      );
    },
  );
}

// FirebaseFirestore firebase = FirebaseFirestore.instance;
// bool checkDoc(String collection, String id) async {
//   var a = await firebase.collection(collection).doc(id).get();
//   if (a.exists) {
//     return true;
//   } else {
//     return false;
//   }
// }
