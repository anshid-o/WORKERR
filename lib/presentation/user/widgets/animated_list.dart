import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/presentation/user/screens/main/workers_list.dart';

class MyAnimatedList extends StatefulWidget {
  const MyAnimatedList({Key? key}) : super(key: key);

  @override
  State<MyAnimatedList> createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  List<FavWorkers> items = List.from(favWorkers);
  final listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      itemBuilder: ((context, index, animation) => items.isNotEmpty
          ? ListItemWidget(
              item: items[index],
              animation: animation,
              onClicked: () => removeItem(index))
          : const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                  child: Text(
                'Not has Favorite workers',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            )),
      initialItemCount: items.isNotEmpty ? items.length : 1,
    );
  }

  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ListItemWidget(
            item: removedItem, animation: animation, onClicked: () {}),
        duration: const Duration(milliseconds: 600));
    setState(() {
      favWorkers.removeAt(index);
    });
  }
}

// void insertItem(String name) {
//   final newIndex = 1;
//   final newItem = FavWorkers(name: name, url: 'assets/3.jpj');
//   items.insert(newIndex, newItem);

//   listKey.currentState!
//       .insertItem(newIndex, duration: Duration(milliseconds: 600));
// }
