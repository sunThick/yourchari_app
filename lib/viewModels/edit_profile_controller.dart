// flutter

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import '../../constants/othes.dart';
import '../../domain/firestore_user/firestore_user.dart';
import '../constants/string.dart';

final editProfileNotifierProvider =
    ChangeNotifierProvider.autoDispose(((ref) => EditProfileController(ref)));

class EditProfileController extends ChangeNotifier {
  late FirestoreUser currentFirestoreUser;
  EditProfileController(ref) {
    MainController mainController = ref.watch(mainProvider);
    currentFirestoreUser = mainController.currentFirestoreUser;
  }

  File? croppedFile;
  Uint8List? compress;
  late String userImageURL = currentFirestoreUser.userImageURL;
  bool isUpdating = false;
  bool isUpdated = false;

  void startUpdating() {
    isUpdating = true;
    notifyListeners();
  }

  Future<void> endUpdating({required context}) async {
    isUpdated = true;
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
  }

  late TextEditingController userNameEditingController =
      TextEditingController(text: currentFirestoreUser.userName);
  late TextEditingController displayNameEditingController =
      TextEditingController(text: currentFirestoreUser.displayName);
  late TextEditingController introductionEdtitingController =
      TextEditingController(text: currentFirestoreUser.introduction);
  String newImageURL = "";

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
        file: croppedFile!, minWidth: 200, minHeight: 200);
    notifyListeners();
  }

  Future<String> uploadImageAndGetURL(
      {required uid, required Uint8List compress}) async {
    //uuid
    final String fileName = returnFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putData(compress);
    // users/uid/ファイル名 のURLを取得
    return storageRef.getDownloadURL();
  }

  Future<void> updateFirestoreUser(
      {required context, required MainController mainController}) async {
    startUpdating();
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    final newDisplayName = displayNameEditingController.text.trim();
    final newIntroduction = introductionEdtitingController.text.trim();
    if (compress != null) {
      newImageURL = await uploadImageAndGetURL(compress: compress!, uid: uid);
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'displayName': newDisplayName,
        'introduction': newIntroduction,
        'userImageURL': newImageURL
      });
      mainController.updateImageURL(newImageURL: newImageURL);
      mainController.updateProfile(
          newDisplayName: newDisplayName, newIntroduction: newIntroduction);
    } else {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'displayName': newDisplayName,
        'introduction': newIntroduction,
      });
      mainController.updateProfile(
          newDisplayName: newDisplayName, newIntroduction: newIntroduction);
    }
    endUpdating(context: context);
    showToast(msg: '保存しました');
  }
}
