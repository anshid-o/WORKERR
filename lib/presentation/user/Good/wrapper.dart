import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workerr_app/presentation/user/Good/authenticate.dart';
import 'package:workerr_app/presentation/user/Good/backend/auth.dart';
import 'package:workerr_app/presentation/user/screens/screen_main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return ScreenMain();
    }
  }
}
