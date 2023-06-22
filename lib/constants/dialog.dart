import 'package:flutter/cupertino.dart';
import 'package:yourchari_app/constants/routes.dart';

import '../viewModels/main_controller.dart';
import '../viewModels/mute_users_controller.dart';

// chari詳細ページのsheet
void chariPassiveSheet(BuildContext context,
    {required MainController mainController,
    required UserMuteController muteUsersController,
    required String passiveUid}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () async =>
              toPassiveUserPage(context: context, userId: passiveUid),
          child: const Text('ユーザーのプロフィール'),
        ),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _userMuteDialog(context,
                  mainController: mainController,
                  muteUsersController: muteUsersController,
                  passiveUid: passiveUid);
            },
            child: mainController.muteUids.contains(passiveUid)
                ? const Text('ミュートを解除')
                : const Text('このユーザーをミュートする')),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {},
          child: const Text('この投稿を通報する'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}

// ユーザーミュートの確認
void _userMuteDialog(BuildContext context,
    {required UserMuteController muteUsersController,
    required MainController mainController,
    required String passiveUid}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('このユーザーをミュートしますか？'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            muteUsersController.muteUser(
                mainController: mainController, passiveUid: passiveUid);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
