import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';

import '../../constants/string.dart';

final verifyPasswordRestProvider =
    ChangeNotifierProvider(((ref) => VerifyPasswordResetController()));

class VerifyPasswordResetController extends ChangeNotifier {
  String email = "";

  Future<void> sendPasswordResetEmail({required BuildContext context}) async {
    try {
      // passwordをresetするためのメールを送る
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      showToast(msg: emailSendedMsg);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "auth/invalid-email":
          msg = invalidEmailMsg;
          break;
        case "auth/missing-android-pkg-name":
          msg = missingAndroidPkgNameMsg;
          break;
        case "auth/missing-ios-bundle-id":
          msg = missingIosBundleIdMsg;
          break;
        case "auth/user-not-found":
          msg = userNotFoundMsg;
          break;
        default:
          msg = e.code;
      }
      showToast(msg: msg);
    }
  }
}
