
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:yourchari_app/viewModels/main_controller.dart';

import '../../constants/enums.dart';
import '../../constants/routes.dart';
import '../../constants/string.dart';
import '../../viewModels/auth/account_controller.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final MainController mainController = ref.watch(mainProvider);
    final AccountController accountController = ref.watch(accountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(accountTitle),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text(updatePasswordText),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                accountController.reauthenticationState =
                    ReauthenticationState.updatePassword;
                toReauthenticationPage(
                    context: context, accountController: accountController);
              }),
          ListTile(
              title: const Text(updateEmailText),
              trailing: const Icon(Icons.arrow_forward_ios),
              // reauthenticationするページに飛ばす
              onTap: () {
                accountController.reauthenticationState =
                    ReauthenticationState.updateEmail;
                toReauthenticationPage(
                    context: context, accountController: accountController);
              }),
          // ListTile(
          //   title: const Text(logoutText),
          //   onTap: () async => await .logout(context: context),
          // )
        ],
      ),
    );
  }
}
