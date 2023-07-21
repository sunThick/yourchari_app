import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/views/auth/components/password_field_and_button_scrreen.dart';

import '../../viewModels/auth/update_password_controller.dart';

class UpdatePasswordPage extends ConsumerWidget {
  const UpdatePasswordPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UpdatePasswordModel updatePasswordModel =
        ref.watch(updatePasswordProvider);
    final TextEditingController textEditingController =
        TextEditingController(text: updatePasswordModel.newPassword);
    return PasswordFieldAndButtonScreen(
        appbarTitle: 'パスワードを設定',
        buttonText: 'パスワードを更新する',
        hintText: '新しいパスワードを入力してください。',
        textEditingController: textEditingController,
        onChanged: (value) => updatePasswordModel.newPassword = value,
        onPressed: () async =>
            await updatePasswordModel.updatePassword(context: context));
  }
}
