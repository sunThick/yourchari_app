import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';

import '../../constants/enums.dart';
import '../../constants/routes.dart';
import '../../constants/string.dart';
import '../../constants/void.dart';

final accountProvider = ChangeNotifierProvider(((ref) => AccountController()));

class AccountController extends ChangeNotifier {
  User? currentUser = returnAuthUser();
  String password = "";
  ReauthenticationState reauthenticationState =
      ReauthenticationState.initialValue;

  Future<void> reauthenticateWithCredential(
      {required BuildContext context}) async {
    // まず再認証をする
    currentUser = returnAuthUser();
    final String email = currentUser!.email!;
    // 認証情報
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await currentUser!.reauthenticateWithCredential(credential);
      switch (reauthenticationState) {
        case ReauthenticationState.initialValue:
          break;
        case ReauthenticationState.updatePassword:
          toUpdatePasswordPage(context: context);
          break;
        case ReauthenticationState.updateEmail:
          toUpdateEmailPage(context: context);
          break;
      }
    } on FirebaseAuthException catch (e) {
      String msg = e.code;
      switch (e.code) {
        case "wrong-password":
          msg = wrongPasswordMsg;
          break;
        case "invalid-email":
          msg = invalidEmailMsg;
          break;
        case "invalid-credential":
          msg = invalidCredentialMsg;
          break;
        case "user-not-found":
          msg = userNotFoundMsg;
          break;
        case "user-mismatch":
          msg = userMismatchMsg;
          break;
      }
      showToast(msg: msg);
    }
  }
}
