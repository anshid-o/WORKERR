import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:workerr_app/core/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kc10,
      child: const Center(
        child: SpinKitRotatingPlain(
          color: kc30,
          size: 100,
        ),
      ),
    );
  }
}
