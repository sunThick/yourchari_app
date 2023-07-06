import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/mute_users_controller.dart';
import 'package:yourchari_app/views/components/components.dart';

import '../constants/dialog.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final UserMuteController userMuteController = ref.watch(userMuteProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('プロフィール'),
        actions: [
          if (!mainController.muteUids.contains(userId) &&
              mainController.currentFirestoreUser.uid != userId)
            InkWell(
              child: const Icon(Icons.more_vert),
              onTap: () {
                passiveUserSheet(context,
                    mainController: mainController,
                    passiveUid: userId,
                    userMuteController: userMuteController);
              },
            )
        ],
      ),
      body: profileAndPassiveBody(
        context: context,
        userId: userId,
      ),
    );
  }
}
