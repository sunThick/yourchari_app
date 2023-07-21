import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/auth/account_controller.dart';

import '../../constants/enums.dart';
import '../../views/auth/password_field_and_button_scrreen.dart';

class ReauthenticationPage extends ConsumerWidget {
  const ReauthenticationPage({
    Key? key,
    required this.accountController,
  }) : super(key: key);
  final AccountController accountController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController =
        TextEditingController(text: accountController.password);
    String title = "";
    if (accountController.reauthenticationState ==
        ReauthenticationState.updatePassword) {
      title = 'パスワードを更新';
    } else if ((accountController.reauthenticationState ==
        ReauthenticationState.updateEmail)) {
      title = 'メールアドレスを更新';
    }

    return PasswordFieldAndButtonScreen(
      appbarTitle: title,
      hintText: '現在のパスワードを入力してください',
      buttonText: '続ける',
      textEditingController: textEditingController,
      onChanged: (value) => accountController.password = value,
      onPressed: () async => await accountController
          .reauthenticateWithCredential(context: context),
    );
  }
}
