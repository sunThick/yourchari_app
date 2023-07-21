import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';

import '../../constants/string.dart';
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
      const String msg = updatedPasswordMsg;
      showToast(msg: msg);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "requires-recent-login":
          msg = requiresRecentLoginMsg;
          break;
        case "weak-password":
          msg = weakPasswordMsg;
          break;
      }
      showToast(msg: msg);
    }
  }
}
