import 'package:flutter/material.dart';
import 'package:workerr_app/core/constants.dart';

class UpdateStatus extends StatelessWidget {
  const UpdateStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        // bottomOpacity: 0,
        // foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
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
            'Update Status',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
