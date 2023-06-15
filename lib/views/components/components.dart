import 'package:flutter/material.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';

Widget buildAvatarImage(
    {required FirestoreUser passiveUser,
    required FirestoreUser currentFirestoreUser,
    required ProfileController profileController,
    required double radius}) {
  return passiveUser.uid == currentFirestoreUser.uid
      ? profileController.croppedFile == null
          ? currentFirestoreUser.userImageURL.isEmpty
              ? CircleAvatar(radius: radius, child: const Icon(Icons.person))
              : CircleAvatar(
                  backgroundImage:
                      NetworkImage(currentFirestoreUser.userImageURL),
                  radius: radius)
          : CircleAvatar(
              backgroundImage: Image.file(profileController.croppedFile!).image,
              radius: radius)
      : passiveUser.userImageURL.isEmpty
          ? const CircleAvatar(child: Icon(Icons.person))
          : CircleAvatar(
              backgroundImage: NetworkImage(passiveUser.userImageURL),
              radius: radius);
}

Widget buildButton({
  required String text,
  required int value,
}) =>
    Column(children: [
      Text(
        '$value',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 2),
      Text(
        text,
        style: const TextStyle(fontSize: 15),
      )
    ]);
