import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/edit_profile_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EditProfileController editProfileController =
        ref.watch(editProfileNotifierProvider);
    final MainController mainController = ref.watch(mainProvider);
    final FirestoreUser currentFirestoreUser =
        mainController.currentFirestoreUser;

    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('プロフィールを編集'),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Center(child: Icon(Icons.cancel_outlined)),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              editProfileController.selectImage();
                            },
                            child: editProfileController.compress == null
                                ? currentFirestoreUser.userImageURL == ""
                                    ? const CircleAvatar(
                                        radius: 40,
                                        child: Icon(Icons.add_a_photo_outlined),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            currentFirestoreUser.userImageURL),
                                      )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: MemoryImage(
                                        editProfileController.compress!),
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Text('名前'),
                            ],
                          ),
                          TextFormField(
                            onEditingComplete: () {
                              editProfileController
                                      .displayNameEditingController.text =
                                  editProfileController
                                      .displayNameEditingController.text
                                      .trim();
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            maxLength: 15,
                            controller: editProfileController
                                .displayNameEditingController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "名前を追加する"),
                          ),
                          const Row(
                            children: [
                              Text("自己紹介"),
                            ],
                          ),
                          TextFormField(
                            maxLength: 100,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            controller: editProfileController
                                .introductionEdtitingController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "プロフィールに自己紹介を追加する"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                editProfileController.updateFirestoreUser(
                                    context: context,
                                    mainController: mainController);
                              },
                              child: const Text('保存'))
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (editProfileController.isUpdating == true)
          ColoredBox(
            color: Colors.black54,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                editProfileController.isUpdated
                    ? const Icon(
                        Icons.done,
                        size: 100,
                        color: Colors.blue,
                      )
                    : const CircularProgressIndicator()
              ],
            )),
          ),
      ],
    );
  }
}
