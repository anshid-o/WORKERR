import 'package:flutter/material.dart';
import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

import 'package:workerr_app/presentation/user/widgets/my_app_bar.dart';
import 'package:workerr_app/presentation/user/widgets/top_list_card.dart';

class ScreenTopList extends StatelessWidget {
  const ScreenTopList({Key? key}) : super(key: key);

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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: MyAppBar(
              name: 'Top Workers',
            )),
        body: ListView.builder(
          itemBuilder: ((context, index) => TopListCard(
                i: index,
              )),
          itemCount: workers.length,
        ),
      ),
    );
  }
}
