import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import '../components/components.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final userId = mainController.currentFirestoreUser.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          mainController.currentFirestoreUser.userName,
        ),
      ),
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
              onTap: () {
                toLikechariListPage(
                    context: context,
                    uid: mainController.currentFirestoreUser.uid);
              },
              child: const ListTile(
                title: Text('いいねした投稿'),
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
          userId: userId,
          isProfile: true),
    );
  }
}
