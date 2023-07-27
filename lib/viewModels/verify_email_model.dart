
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/constants/void.dart';

final verifyEmailProvider =
    ChangeNotifierProvider(((ref) => VerifyEmailModel()));

class VerifyEmailModel extends ChangeNotifier {
  VerifyEmailModel() {
    init();
  }

  Future<void> init() async {
    User? user = returnAuthUser();
    await user!.reload();
    user = returnAuthUser();
    // ユーザーのメールアドレス宛にメールが送信される
    if (!user!.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> reloadUser(
      {required User initialUser, required BuildContext context}) async {
    await initialUser.reload();
    initialUser = returnAuthUser()!;
    notifyListeners();
    toMyApp(context: context);
  }
}
