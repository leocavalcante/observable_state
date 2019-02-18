import 'package:example/app_state.dart';
import 'package:example/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

class FirebaseService implements Service {
  FirebaseService({
    @required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  @override
  Future<User> login(String email, String password) async {
    try {
      final firebaseUser = await firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      return _userFromFirebaseUser(firebaseUser);
    } on PlatformException catch (error) {
      if ('ERROR_USER_NOT_FOUND' == error.code) {
        return null;
      }
    }

    return null;
  }

  @override
  Future<User> currentUser() async {
    final firebaseUser = await firebaseAuth.currentUser();
    return _userFromFirebaseUser(firebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }

    return User(uid: firebaseUser.uid);
  }
}
