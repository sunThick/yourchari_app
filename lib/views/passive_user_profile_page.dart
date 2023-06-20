import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';
import 'package:yourchari_app/views/components/components.dart';
import '../viewModels/passive_user_page_controller.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final PassiveUserController passiveUserController =
        ref.watch(passiveUserNotifierProvider);
    final ProfileController profileController =
        ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('passive')),
      body: profileAndPassiveBody(
        context: context,
        mainController: mainController,
        passiveUserController: passiveUserController,
        profileController: profileController,
        userId: userId,
        // asyncValue: asyncValue,
        ref: ref
      ),
    );
  }
}
