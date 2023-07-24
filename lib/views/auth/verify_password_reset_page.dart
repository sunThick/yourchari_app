import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewModels/auth/verify_password_reset_controller.dart';
import 'components/textdield_and_button_screen.dart';

class VerifyPasswordResetPage extends ConsumerWidget {
  const VerifyPasswordResetPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VerifyPasswordResetController verifyPasswordResetController =
        ref.watch(verifyPasswordRestProvider);
    final TextEditingController controller =
        TextEditingController(text: verifyPasswordResetController.email);
    return TextFieldAndButtonScreen(
      appbarTitle: "パスワードを忘れた場合",
      buttonText: "パスワードを変更するメールを送信する",
      hintText: "メールアドレスを入力してください。",
      controller: controller,
      onChanged: (value) => verifyPasswordResetController.email = value,
      onPressed: () async => await verifyPasswordResetController
          .sendPasswordResetEmail(context: context),
    );
  }
}


