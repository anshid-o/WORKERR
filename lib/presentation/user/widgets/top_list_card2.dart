import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/screens/main/workers_list.dart';

class TopList2 extends StatefulWidget {
  int i;
  TopList2({
    required this.i,
    Key? key,
  }) : super(key: key);

  @override
  State<TopList2> createState() => _TopList2State();
}

class _TopList2State extends State<TopList2> {
  List<String> workers = [
    'Anshid O',
    'Yaseen',
    'Hisham',
    'Nijas Ali',
    'Sidheeq',
    'Junaid',
    'Althaf',
    'Adil',
    'Mishal',
  ];
  List<String> works2 = [
    'Plumbing',
    'Painting',
    'Fabrication works',
    'Electric repairs',
    'Mechanic',
    'Driver',
    'Plumbing',
    'Painting',
    'Fabrication works',
  ];

  @override
  Widget build(BuildContext context) {
    bool flag = true;
    int j;
    for (j = 0; j < favWorkers.length; j++) {
      if (favWorkers[j].name == workers[widget.i]) {
        setState(() {
          flag = false;
        });
        break;
      }
    }
    bool like = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: kgoldgd, borderRadius: BorderRadius.circular(15)),
        // color: Colors.white,
        child: ExpansionTile(
          leading: const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/abbc.jpg'),
          ),
          title: Text(
            workers[widget.i],
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: kc30,
                letterSpacing: 0),
          ),
          subtitle: Text(
            works2[widget.i],
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: kc30,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              // insertItem(workers[i]);

              if (!flag) {
                showDone(context, '${workers[widget.i]} removed from favorites',
                    Icons.error_outline, Colors.red);

                favWorkers.removeAt(j);
              }

              if (flag) {
                favWorkers.add(FavWorkers(name: workers[widget.i]));
                showDoneTop(context, workers[widget.i]);
              }
              setState(() {
                flag = !flag;
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (ctx) => const MyTabbedAppBar(),
              //   ),
              // );
            },
            icon: !flag
                ? const Icon(
                    CupertinoIcons.heart_solid,
                    color: kred,
                    shadows: kshadow,
                  )
                : const Icon(
                    CupertinoIcons.heart,
                    color: kred,
                    shadows: kshadow,
                  ),
          ),
          children: [
            ksize(y: 5),
            const Text(
              'Rating : 4.4',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: kc30),
            ),
            ksize(y: 5),
            const Text(
              'Experience : 3 Years',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: kc30),
            ),
            const Text(
              'Areakode',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kc30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showDoneTop(BuildContext ctx, String name) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Row(
      children: [
        Text(
          '$name is added to favorite list',
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        kwidth,
        const Icon(
          Icons.favorite_rounded,
          color: Colors.red,
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  ));
}
