// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/views/components/default_user_image.dart';
// models
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/main/profile_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // 写真を更新後のcroppedfileがあればcroppedfileをviewに表示
          child: profileModel.croppedFile != null
              ? CircleAvatar(
                  backgroundImage: Image.file(profileModel.croppedFile!).image,
                )
              : Container(
                  // croppedfileがなければcloudstorageのファイルを表示
                  child: mainModel.firestoreUser.userImageURL.isEmpty
                      ? const DefaultUserImage(
                          length: 50,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              mainModel.firestoreUser.userImageURL)),
                ),
        ),
        ElevatedButton(
          onPressed: () async => await profileModel.uploadUserImage(
              currentUserDoc: mainModel.currentUserDoc),
          child: const Text('edit photo'),
        )
      ],
    );
  }
}
