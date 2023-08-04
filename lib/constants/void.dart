import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../domain/chari/chari.dart';

User? returnAuthUser() {
  return FirebaseAuth.instance.currentUser;
}

List<DocumentSnapshot<Map<String, dynamic>>> chariWithoutMuteUser(
    {required List<DocumentSnapshot<Map<String, dynamic>>> chariDocs,
    required MainController mainController}) {
  final List<DocumentSnapshot<Map<String, dynamic>>> chariWithoutMuteUserDocs =
      [];
  final List<String> muteUids = mainController.muteUids;
  for (final chariDoc in chariDocs) {
    if (chariDoc.data() != null) {
      final Chari chari = Chari.fromJson(chariDoc.data()!);
      if (!muteUids.contains(chari.uid)) {
        chariWithoutMuteUserDocs.add(chariDoc);
      }
    }
  }
  return chariWithoutMuteUserDocs;
}

List<DocumentSnapshot<Map<String, dynamic>>> userListWithoutMuteUser(
    {required List<DocumentSnapshot<Map<String, dynamic>>> userDocs,
    required MainController mainController}) {
  final List<DocumentSnapshot<Map<String, dynamic>>>
      userListWithoutMuteUserDocs = [];
  for (final userDoc in userDocs) {
    if (userDoc.data() != null) {
      final FirestoreUser firestoreUser =
          FirestoreUser.fromJson(userDoc.data()!);
      if (!mainController.muteUids.contains(firestoreUser.uid)) {
        userListWithoutMuteUserDocs.add(userDoc);
      }
    }
  }
  return userListWithoutMuteUserDocs;
}

void showFlashDialog(
    {required BuildContext context,
    required Widget content,
    required Widget Function(BuildContext, FlashController<Object?>,
            void Function(void Function()))?
        positiveActionBuilder}) {
  context.showFlashDialog(
    content: content,
    backgroundColor: Colors.white,
    negativeActionBuilder: (_, controller, __) {
      return TextButton(
          onPressed: () async => await controller.dismiss(),
          child: const Text('戻る'));
    },
    positiveActionBuilder: positiveActionBuilder,
  );
}
