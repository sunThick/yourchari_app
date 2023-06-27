import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourchari_app/constants/list.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/viewModels/create_chari_model.dart';

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

void cancelDialog(
  BuildContext context,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('このまま戻ると、編集内容は破棄されます'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('編集を続ける')),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
          child: const Text('破棄する'),
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

void categoryPickerDialog(BuildContext context,
    {required CreateChariController createChariController}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: CupertinoPicker(
          magnification: 1.22,
          squeeze: 1.2,
          useMagnifier: true,
          itemExtent: 32.0,
          onSelectedItemChanged: (i) {
            final category = categoryItem[i];
            createChariController.onCategoryChanged(value: category);
          },
          children: List<Widget>.generate(categoryItem.length, (int index) {
            return Center(
              child: Text(
                categoryItem[index],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

void createChariPreviewImage(BuildContext context,
    {required image, required CreateChariController createChariController}) {
  showCupertinoModalPopup<void>(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InteractiveViewer(
                minScale: 0.1,
                maxScale: 5,
                child: Image.file(image),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 3 / 4,
              ),
              Material(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      '削除',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      createChariController.deleteListImage(image: image);
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      );
    },
  );
}
