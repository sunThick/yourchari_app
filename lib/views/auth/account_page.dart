import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:yourchari_app/viewModels/main_controller.dart';

import '../../constants/enums.dart';
import '../../constants/routes.dart';
import '../../constants/void.dart';
import '../../viewModels/auth/account_controller.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key, required this.homeContext}) : super(key: key);

  final BuildContext homeContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final MainController mainController = ref.watch(mainProvider);
    final AccountController accountController = ref.watch(accountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text('パスワードを更新'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                accountController.reauthenticationState =
                    ReauthenticationState.updatePassword;
                toReauthenticationPage(
                    context: context,
                    accountController: accountController,
                    homeContext: homeContext);
              }),
          ListTile(
              title: const Text('メールアドレスを変更'),
              subtitle: Text(returnAuthUser()!.email!),
              trailing: const Icon(Icons.arrow_forward_ios),
              // reauthenticationするページに飛ばす
              onTap: () {
                accountController.reauthenticationState =
                    ReauthenticationState.updateEmail;
                toReauthenticationPage(
                    context: context,
                    accountController: accountController,
                    homeContext: homeContext);
              }),
          ListTile(
              title: const Text(
                'アカウントを削除',
                style: TextStyle(color: Colors.red),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                accountController.reauthenticationState =
                    ReauthenticationState.deleteUser;
                toReauthenticationPage(
                    context: context,
                    accountController: accountController,
                    homeContext: homeContext);
              })
        ],
      ),
    );
  }
}
