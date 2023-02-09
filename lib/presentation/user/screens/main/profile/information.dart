import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';
import 'package:workerr_app/presentation/user/screens/main/profile/screen_feedback.dart';
import 'package:workerr_app/presentation/user/widgets/my_text_form.dart';

class CardItem {
  final String url;
  final String title;
  final String subtitle;

  CardItem({required this.url, required this.title, required this.subtitle});
}

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  List<CardItem> items = [
    CardItem(
      url: 'assets/mine.jpg',
      title: 'Anshid O',
      subtitle: 'Team Lead',
    ),
    CardItem(
      url: 'assets/persons/mishal.jpg',
      title: 'Mishal M',
      subtitle: 'Team Member',
    ),
    CardItem(
      url: 'assets/persons/jaleel.jpg',
      title: 'Mishal Jaleel',
      subtitle: 'Team Member',
    ),
  ];
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
            'Project Workerr',
            style: TextStyle(
              color: kc60,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight30,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Team  : Workerr',
                style: TextStyle(
                    color: kc60, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            kheight,
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return buildCard(item: items[index]);
                },
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 12,
                ),
              ),
            ),
            kheight30,
            ListTile(
              onTap: () {},
              title: const Text(
                'Help',
                style: TextStyle(color: kc60),
              ),
              subtitle: const Text(
                'Find answers to your questions',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenFeedback(),
                    ));
              },
              title: const Text(
                'Leave feedback',
                style: TextStyle(color: kc60),
              ),
              subtitle: const Text(
                'Tell us about your thouhhts',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Workerr Terms of Service',
                style: TextStyle(color: kc60),
              ),
              subtitle: const Text(
                'Read Workerr\'s Terms of Service',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Workerr Privacy Policy',
                style: TextStyle(color: kc60),
              ),
              subtitle: const Text(
                'Read Mobile Privacy Policy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () async {
                final to = 'anshidkoolimad@gmail.com';
                final subject = 'Contact to Workerr Group';
                final message =
                    'Hello Workerr Team,\n\nCheck out this email that sented to contact to workerr group.';
                final ux = Uri(
                    scheme: 'mailto',
                    path: to,
                    queryParameters: {'subject': subject, 'body': message});
                String url = ux.toString();
                if (await canLaunch(url)) {
                  await launch(
                    url,
                  );
                } else {
                  print('Could not launch $url');
                }
              },
              title: const Text(
                'Contact Us',
                style: TextStyle(color: kc60),
              ),
              subtitle: const Text(
                'Sent email to contact us',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const ListTile(
              // onTap: () {},
              title: Text(
                'App version',
                style: TextStyle(color: kc60),
              ),
              subtitle: Text(
                '1.00',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({required CardItem item}) {
    return Container(
      width: 270,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
              image: AssetImage('assets/no2.jpg'), fit: BoxFit.fill)
          // gradient: kredgd,
          ),
      child: Column(
        children: [
          kheight30,
          kheight,
          Text(
            item.subtitle,
            style: const TextStyle(color: kc30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(item.url),
            ),
          ),
          Text(
            item.title,
            style: const TextStyle(color: kc30, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
