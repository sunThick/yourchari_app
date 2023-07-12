// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verifyEmailProvider =
    ChangeNotifierProvider(((ref) => VerifyEmailModel()));

class VerifyEmailModel extends ChangeNotifier {
  VerifyEmailModel() {
    init();
  }

  Future<void> init() async {
    final User? user = FirebaseAuth.instance.currentUser;
    // ユーザーのメールアドレス宛にメールが送信される
    await user?.sendEmailVerification();
  }
}
