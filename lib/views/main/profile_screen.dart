// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';

import '../../domain/chari/chari.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final ProfileController profileController = ref.watch(profileNotifierProvider);
    final MainController mainController = ref.watch(mainProvider);

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
                  child: mainController.currentFirestoreUser.userImageURL.isNotEmpty
                      ? Image.network(
                          mainController.currentFirestoreUser.userImageURL,
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
                  child: profileController.croppedFile != null
                      ? CircleAvatar(
                          radius: profileHeight / 2,
                          backgroundImage:
                              Image.file(profileController.croppedFile!).image,
                        )
                      : Container(
                          // croppedfileがなければcloudstorageのファイルを表示
                          child: mainController
                                  .currentFirestoreUser.userImageURL.isEmpty
                              ? const CircleAvatar(
                                  radius: profileHeight / 2,
                                  child: Icon(Icons.person))
                              : CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundImage: NetworkImage(mainController
                                      .currentFirestoreUser.userImageURL)),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            mainController.currentFirestoreUser.userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(text: 'chari', value: profileController.chariDocs.length),
            buildButton(
                text: 'follwing',
                value: mainController.currentFirestoreUser.followingCount),
            buildButton(
                text: 'follwers',
                value: mainController.currentFirestoreUser.followerCount)
          ],
        ),
        ElevatedButton(
            onPressed: () async => profileController.uploadImage(
                currentUserDoc: mainController.currentUserDoc),
            child: const Text('profile')),
        const Divider(color: Colors.black),
        Expanded(
          child: ListView.builder(
            itemCount: profileController.chariDocs.length, // moviesの長さだけ表示
            itemBuilder: (BuildContext context, int index) {
              final doc = profileController.chariDocs[index];
              final Chari chari = Chari.fromJson(doc.data()!);
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Image.network(
                  (chari.imageURL[0]),
                )),
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
              ),
            ]),
      );
}
