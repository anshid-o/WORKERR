import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';

class FavWorkers {
  final String name;
  final String url;

  const FavWorkers({required this.name, this.url = 'assets/3.jpg'});
}

List<FavWorkers> favWorkers = [
  const FavWorkers(name: 'Mishal', url: 'assets/abbc.jpg'),
  const FavWorkers(name: 'Jaleel', url: 'assets/2.jpg'),
  const FavWorkers(name: 'Yaseeen', url: 'assets/3.jpg'),
  const FavWorkers(name: 'Althaf', url: 'assets/2.jpg'),
  const FavWorkers(name: 'Hisham', url: 'assets/abbc.jpg'),
];

class ListItemWidget extends StatelessWidget {
  final FavWorkers item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
      sizeFactor: animation, key: ValueKey(item.url), child: buildItem());

  Widget buildItem() => Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: ListTile(
          contentPadding: const EdgeInsets.all(14),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(item.url),
          ),
          title: Text(
            item.name,
            style: const TextStyle(
                fontSize: 23, color: kc30, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: kred,
              size: 32,
            ),
            onPressed: onClicked,
          ),
        ),
      );
}
