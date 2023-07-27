// flutter

import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';
import 'package:yourchari_app/constants/routes.dart' as routes;
// domain

final signupNotifierProvider =
    ChangeNotifierProvider((ref) => SignupController());

class SignupController extends ChangeNotifier {
  User? currentUser;

  // auth
  String name = "";
  String userImageURL = "";
  bool isObscure = true;

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  Future<void> createUser({required BuildContext context}) async {
    String msg = "";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text);
      // ignore: use_build_context_synchronously
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          msg = "通信がエラーになったのか、またはタイムアウトになりました。通信環境がいい所で再度やり直してください。";
          break;
        case "weak-password": //バリデーションでいかないようにするので、基本的にはこのコードはこない
          msg = "パスワードが短すぎます。6文字以上を入力してください。";
          break;
        case "invalid-email": //バリデーションでいかないようにするので、基本的にはこのコードはこない
          msg = "メールアドレスが正しくありません";
          break;
        case "email-already-in-use":
          msg = "メールアドレスがすでに使用されています。ログインするか別のメールアドレスで作成してください";
          break;
        default: //想定外
          msg = e.code;
      }
      showToast(msg: msg);
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
