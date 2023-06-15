// flutter

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/constants/routes.dart' as routes;

final loginNotifierProvider =
    ChangeNotifierProvider(((ref) => LoginController()));

class LoginController extends ChangeNotifier {
  User? currentUser;
  // auth
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('メールアドレスのフォーマットが正しくありません'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('メールアドレスのフォーマットが正しくありません'),
          ),
        );
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('現在指定したメールアドレスは使用できません'),
          ),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('指定したメールアドレスは登録されていません'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('パスワードが間違っています'),
          ),
        );
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
