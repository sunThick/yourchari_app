import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';
import '../../constants/void.dart';

final updatePasswordProvider =
    ChangeNotifierProvider(((ref) => UpdatePasswordModel()));

class UpdatePasswordModel extends ChangeNotifier {
  String newPassword = "";

  Future<void> updatePassword({required BuildContext context}) async {
    final User user = returnAuthUser()!;
    try {
      await user.updatePassword(newPassword);
      Navigator.pop(context);
      Navigator.pop(context);
      const String msg = 'メールアドレスを更新しました';
      showToast(msg: msg);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "requires-recent-login":
          msg = 'ログインしてください';
          break;
        case "weak-password":
          msg = 'パスワードは6文字以上で入力してください';
          break;
      }
      showToast(msg: msg);
    }
  }
}
