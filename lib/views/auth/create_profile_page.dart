import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/auth/create_profile_controller.dart';

class CreateProfilePage extends ConsumerWidget {
   const CreateProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreateProfileController createProfileController =
        ref.watch(createProfileNotifierProvider);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('プロフィールを完成させてアプリを始めよう'),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                createProfileController.selectImage();
              },
              child: createProfileController.compress == null
                  ? const CircleAvatar(
                      radius: 50, child: Icon(Icons.add_a_photo_outlined))
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          MemoryImage(createProfileController.compress!)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('ユーザーネーム（必須・英数字のみ）'),
              ],
            ),
            TextFormField(
              onEditingComplete: () {
                createProfileController.userNameEditingController.text =
                    createProfileController.userNameEditingController.text
                        .trim();
                FocusManager.instance.primaryFocus!.unfocus();
              },
              maxLength: 10,
              controller: createProfileController.userNameEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "必須。10字まで"),
            ),
           Row(
              children: [
                Text('名前'),
              ],
            ),
            TextFormField(
              onEditingComplete: () {
                createProfileController.displayNameEditingController.text =
                    createProfileController.displayNameEditingController.text
                        .trim();
                FocusManager.instance.primaryFocus!.unfocus();
              },
              maxLength: 15,
              controller: createProfileController.displayNameEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "名前を追加する"),
            ),
            Row(
              children: [
                Text("自己紹介"),
              ],
            ),
            TextFormField(
              maxLength: 100,
              keyboardType: TextInputType.multiline,
              controller: createProfileController.introductionEdtitingController,
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "プロフィールに自己紹介を追加する"),
            ),
            ElevatedButton(
                onPressed: () {
                  createProfileController.createFirestoreUser(
                      context: context, ref: ref);
                },
                child: const Text('保存'))
          ]),
        ),
      ),
    );
  }
}
