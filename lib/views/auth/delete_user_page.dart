import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/dialog.dart';
import 'package:yourchari_app/viewModels/auth/account_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

class DeleteUserPage extends ConsumerWidget {
  const DeleteUserPage({Key? key, required this.homeContext}) : super(key: key);

  final BuildContext homeContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccountController accountController = ref.watch(accountProvider);
    final MainController mainController = ref.watch(mainProvider);
    final firestoreUser = mainController.currentFirestoreUser;
    return Scaffold(
      appBar: AppBar(title: const Text('アカウント削除')),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child:
                  const Text('アカウントを削除しますか？投稿した自転車やいいね等は全て削除されます。また復元はできません。')),
          ElevatedButton(
              onPressed: () {
                deleteUserDialog(context,
                    homeContext: homeContext,
                    accountController: accountController,
                    firestoreUser: firestoreUser);
              },
              child: const Text('アカウントを削除'))
        ]),
      ),
    );
  }
}
