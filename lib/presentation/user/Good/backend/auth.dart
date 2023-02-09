import 'package:firebase_auth/firebase_auth.dart';
import 'package:workerr_app/presentation/user/Good/backend/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser Function(User? event)? get userFromFirebaseUser => null;

  // MyUser? _userFromFirebaseUser(User? user) {
  //   return user!= null ? MyUser(uid: user.uid) : null;
  // }

  // Stream<MyUser?> get user {
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signUp(String email, String password, String name, String pin,
      String phone) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await updateUser(user, name, phone, pin, email, password);
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateUser(user, String name, String phone, String pin,
      String email, String password) async {
    if (pin.isEmpty) {
      pin = '673661';
    }
    if (phone.isEmpty) {
      phone = '';
    }
    await DatabaseService(uid: user.uid)
        .updateUsers(name, phone, '', '', pin, '', email, password, '', '');
  }

  Future signIn(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sigOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class MyUser {
  final String? uid;
  MyUser({this.uid});
}
