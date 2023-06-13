import 'package:flutter/material.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/profile_model.dart';

Widget buildAvatarImage(
    {required FirestoreUser passiveUser,
    required FirestoreUser currentFirestoreUser,
    required ProfileModel profileModel,
    required double radius}) {
  return passiveUser.uid == currentFirestoreUser.uid
      ? profileModel.croppedFile == null
          ? currentFirestoreUser.userImageURL.isEmpty
              ? CircleAvatar(radius: radius, child: const Icon(Icons.person))
              : CircleAvatar(
                  backgroundImage:
                      NetworkImage(currentFirestoreUser.userImageURL),
                  radius: radius)
          : CircleAvatar(
              backgroundImage: Image.file(profileModel.croppedFile!).image,
              radius: radius)
      : passiveUser.userImageURL.isEmpty
          ? const CircleAvatar(child: Icon(Icons.person))
          : CircleAvatar(
              backgroundImage: NetworkImage(passiveUser.userImageURL),
              radius: radius);
}
