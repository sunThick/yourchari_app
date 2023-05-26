// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/profile_model.dart';

import '../../domain/chari/chari.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    const double coverHeight = 150;
    const double profileHeight = 100;
    const bottom = profileHeight / 2;
    const top = coverHeight - profileHeight / 2;
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: bottom),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                  color: Colors.grey,
                  child: mainModel.firestoreUser.userImageURL.isNotEmpty
                      ? Image.network(
                          mainModel.firestoreUser.userImageURL,
                          width: double.infinity,
                          height: coverHeight,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: coverHeight,
                        )),
              Positioned(
                top: top,
                child: Container(
                  // croppedfileがなければcloudstorageのファイルを表示
                  child: profileModel.croppedFile != null
                      ? CircleAvatar(
                          radius: profileHeight / 2,
                          backgroundImage:
                              Image.file(profileModel.croppedFile!).image,
                        )
                      : Container(
                          // croppedfileがなければcloudstorageのファイルを表示
                          child: mainModel.firestoreUser.userImageURL.isEmpty
                              ? const CircleAvatar(
                                  radius: profileHeight / 2,
                                  child: Icon(Icons.person))
                              : CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundImage: NetworkImage(
                                      mainModel.firestoreUser.userImageURL)),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            mainModel.firestoreUser.userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(text: 'chari', value: profileModel.chariDocs.length),
            buildButton(text: 'follwing', value: mainModel.firestoreUser.followingCount),
            buildButton(text: 'follwers', value: mainModel.firestoreUser.followerCount)
          ],
        ),
        const Divider(color: Colors.black),
        Expanded(
          child: ListView.builder(
            itemCount: profileModel.chariDocs.length, // moviesの長さだけ表示
            itemBuilder: (BuildContext context, int index) {
              final doc = profileModel.chariDocs[index];
              final Chari chari = Chari.fromJson(doc.data()!);
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: Center(
                //     child: Image.network(
                //   (chari.imageURL[0]),
                // )),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget buildButton({
    required String text,
    required int value,
  }) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              )
            ]),
      );

  // Widget buildProfileImage() => Container(
  //           // 写真を更新後のcroppedfileがあればcroppedfileをviewに表示
  // child: profileModel.croppedFile != null
  //     ? CircleAvatar(
  //         backgroundImage:
  //             Image.file(profileModel.croppedFile!).image,
  //       )
  //     : Container(
  //         // croppedfileがなければcloudstorageのファイルを表示
  //         child: mainModel.firestoreUser.userImageURL.isEmpty
  //             ? const DefaultUserImage(
  //                 length: 50,
  //               )
  //             : CircleAvatar(
  //                 backgroundImage: NetworkImage(
  //                     mainModel.firestoreUser.userImageURL)),
  //       ),
  //         ),
}
