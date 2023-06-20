import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/passive_user_page_controller.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';
import '../components/components.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileController profileController =
        ref.watch(profileNotifierProvider);
    final MainController mainController = ref.watch(mainProvider);
    final PassiveUserController passiveUserController =
        ref.watch(passiveUserNotifierProvider);
    final userId = mainController.currentFirestoreUser.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('passive')),
      endDrawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                toMuteUsersPage(context: context, uid: userId);
              },
              child: const ListTile(
                title: Text("ミュートているユーザー"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Item 1"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Item 1"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Item 1"),
              ),
            ),
          ],
        ),
      ),
      body: profileAndPassiveBody(
          // asyncValue: asyncValue,
          context: context,
          mainController: mainController,
          passiveUserController: passiveUserController,
          profileController: profileController,
          userId: userId,
          ref: ref),
    );
  }
}
