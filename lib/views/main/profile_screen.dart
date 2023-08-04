
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/dialog.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/viewModels/auth/login_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../components/components.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.homeContext}) : super(key: key);

  final BuildContext homeContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final LoginController loginController = ref.watch(loginNotifierProvider);
    final userId = mainController.currentFirestoreUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mainController.currentFirestoreUser.userName,
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  mainController.currentFirestoreUser.userName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                toCreateChariPage(context: context);
              },
              child: const ListTile(
                leading: Icon(Icons.add_circle),
                title: Text("自転車を投稿"),
              ),
            ),
            const Divider(
              thickness: 10,
            ),
            InkWell(
              onTap: () {
                toEditProfilePage(context: context);
              },
              child: const ListTile(
                title: Text("プロフィールを編集"),
              ),
            ),
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
            const Divider(
              thickness: 10,
            ),
            InkWell(
              onTap: () {
                toAccountPage(context: context, homeContext: homeContext);
              },
              child: const ListTile(
                title: Text("アカウント設定"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("お問い合わせ"),
              ),
            ),
            InkWell(
              onTap: () {
                logoutDialog(context,
                    homeContext: homeContext,
                    mainController: mainController,
                    loginController: loginController);
              },
              child: const ListTile(
                title: Text("ログアウト"),
              ),
            ),
            InkWell(
              onTap: () {
                toTermsOfUserPage(context: context);
              },
              child: const ListTile(
                title: Text("利用規約"),
              ),
            ),
          ],
        ),
      ),
      body: profileAndPassiveBody(
          context: context, userId: userId, isProfile: true),
    );
  }
}
