import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yourchari_app/constants/othes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourchari_app/constants/string.dart';
import 'package:yourchari_app/models/main_model.dart';

final profileProvider = ChangeNotifierProvider(((ref) => ProfileModel()));

class ProfileModel extends ChangeNotifier {
  File? croppedFile;
  MainModel mainModel = MainModel();
  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    //uuid
    final String fileName = returnFileName();

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名 のURLを取得
    return storageRef.getDownloadURL();
  }

  Future<void> uploadImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    // デバイスから画像を取得
    final XFile? xFile = await returnXFile();
    //　写真選択のキャンセルの場合はreturn
    if (xFile == null) {
      return;
    }
    // ユーザーのuidを取得
    final String uid = currentUserDoc.id;
    // xfileを元にc編集されたcroppedFileを取得
    croppedFile = await returnCroppedFile(xFile: xFile, ratioX: 1, ratioY: 1);
    //写真編集の画面でキャンセルの場合はretun
    if (croppedFile == null) {
      return;
    }
    // croppedFileをFileに変換
    final File imageFile = File(croppedFile!.path);
    // imageFileをstorageに投稿、投稿先のURLを取得
    final String url = await uploadImageAndGetURL(uid: uid, file: imageFile);
    // ユーザーのcurrentUmageURlを上記のurlに置換
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
    notifyListeners();
  }
}
