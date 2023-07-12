// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewModels/verify_email_model.dart';

class VerifyEmailPage extends ConsumerWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // modelそのものは使用しないので呼び出すだけでいい
    ref.watch(verifyEmailProvider);
    return Scaffold(
      // 戻る機能をつけないように
      // Appbarは使用しない
      body: Container(
        alignment: Alignment.center,
        child: const Text("メールアドレスを認証するメールを送信しました。認証リンクをクリックしてください。"),
      ),
    );
  }
}
