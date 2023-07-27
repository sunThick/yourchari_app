import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/auth/account_controller.dart';

import '../../constants/enums.dart';
import '../../views/auth/components/password_field_and_button_scrreen.dart';

class ReauthenticationPage extends ConsumerWidget {
  const ReauthenticationPage(
      {Key? key, required this.accountController, required this.homeContext})
      : super(key: key);
  final AccountController accountController;
  final BuildContext homeContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController =
        TextEditingController(text: accountController.password);
    ReauthenticationState reauthenticationState =
        accountController.reauthenticationState;

    String title = "";

    switch (reauthenticationState) {
      case ReauthenticationState.initialValue:
        title = "";
        break;
      case ReauthenticationState.updatePassword:
        title = "パスワードを変更";
        break;
      case ReauthenticationState.updateEmail:
        title = "メールアドレスを変更";
        break;
      case ReauthenticationState.deleteUser:
        title = "アカウントを削除";
        break;
    }

    return PasswordFieldAndButtonScreen(
      appbarTitle: title,
      hintText: '現在のパスワードを入力してください',
      buttonText: '続ける',
      textEditingController: textEditingController,
      onChanged: (value) => accountController.password = value,
      onPressed: () async =>
          await accountController.reauthenticateWithCredential(
              context: context, homeContext: homeContext),
    );
  }
}
