// flutter

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/constants/routes.dart' as routes;
import 'package:yourchari_app/viewModels/main_controller.dart';
import '../../constants/othes.dart';
import '../../domain/firestore_user/firestore_user.dart';

final createProfileNotifierProvider =
    ChangeNotifierProvider(((ref) => CreateProfileController()));

class CreateProfileController extends ChangeNotifier {
  File? croppedFile;
  File? compressedfile;
  Uint8List? compress;
  String userImageURL = "";

  final TextEditingController userNameEditingController =
      TextEditingController();
  final TextEditingController displayNameEditingController =
      TextEditingController();

  Future<void> selectImage() async {
    // デバイスから画像を取得
    final XFile? xFile = await returnXFile();
    //　写真選択のキャンセルの場合はreturn
    if (xFile == null) {
      return;
    }
    // xfileを元にc編集されたcroppedFileを取得
    croppedFile = await returnCroppedFile(xFile: xFile, ratioX: 1, ratioY: 1);
    //写真編集の画面でキャンセルの場合はretun
    if (croppedFile == null) {
      return;
    }
    compress = await returnCompressAndGetData(
        file: croppedFile!, minWidth: 150, minHeight: 150);
    notifyListeners();
  }

  Future<void> createFirestoreUser(
      {required context, required WidgetRef ref}) async {
    final Timestamp now = Timestamp.now();
    final MainController mainController = ref.watch(mainProvider);
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      uid: uid,
      updatedAt: now,
      userImageURL: userImageURL,
      userName: userNameEditingController.text.trim().toLowerCase(),
      displayName: displayNameEditingController.text.trim(),
      followerCount: 0,
      followingCount: 0,
      introduction: '',
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();
    final userNameDocRef = FirebaseFirestore.instance
        .collection("userNames")
        .doc(userNameEditingController.text.trim().toLowerCase());
    final usersDocRef = FirebaseFirestore.instance.collection("users").doc(uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userNameDocRef);
      if (snapshot.exists) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('このユーザーネームは既に使用されています。'),
          ),
        );
        return;
      }
      transaction.set(userNameDocRef, {"uid": uid, "createdAt": now});
      transaction.set(usersDocRef, userData);
      mainController.currentFirestoreUser = firestoreUser.copyWith();
      mainController.isFirestoreUserExist = true;
      notifyListeners();
      routes.toMyApp(context: context);
      showToast(message: 'プロフィールが完成しました');
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}
