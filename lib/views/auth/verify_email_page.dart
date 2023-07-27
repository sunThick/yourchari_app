import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/void.dart';

import '../../viewModels/verify_email_model.dart';

class VerifyEmailPage extends ConsumerWidget {
  const VerifyEmailPage({Key? key, required this.initialUser})
      : super(key: key);

  final User initialUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VerifyEmailModel verifyEmailModel = ref.watch(verifyEmailProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'メールアドレスを確認してください',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 30),
            const Text("メールアドレスを認証するメールを送信しました。"),
            const Text('認証リンクをクリックしてください。'),
            const SizedBox(height: 100),
            InkWell(
              onTap: (() async {
                final user = returnAuthUser();
                await user!.sendEmailVerification();
              }),
              child: const Text('認証メールを再送信する'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  verifyEmailModel.reloadUser(
                      initialUser: initialUser, context: context);
                },
                child: const Text('メールアドレスを認証しました。'))
          ],
        ),
      ),
    );
  }
}
