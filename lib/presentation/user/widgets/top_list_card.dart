import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';
import 'package:workerr_app/presentation/user/widgets/animated_list.dart';
// import 'package:workerr_app/presentation/user/widgets/my_tabbed_appbar.dart';

class TopListCard extends StatelessWidget {
  int i;
  TopListCard({
    required this.i,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 300,
            height: 150,
            // color: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: kgoldgd,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 23,
                        backgroundColor: kblue2,
                        child: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 1, 51, 8),
                          size: 35,
                        ),
                      ),
                      kwidth,
                      Text(
                        workers[i],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: kblue,
                            letterSpacing: 0),
                      ),
                      // Spacer(),
                      kwidth20,

                      const Text(
                        '- Areakode',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: kgreengd,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Driver',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kred,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ksize(y: 5),
                        const Text(
                          'Rating : 4.4',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ksize(y: 5),
                        Text(
                          'Experience : 3 Years',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // insertItem(workers[i]);
                  showDone(context, workers[i]);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (ctx) => const MyTabbedAppBar(),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.star,
                  color: kgold,
                  shadows: kshadow,
                ),
              ),
              Row(
                children: [
                  ksize(y: 8),
                  const Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

void showDone(BuildContext ctx, String name) {
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
