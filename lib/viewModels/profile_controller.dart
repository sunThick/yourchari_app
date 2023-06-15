import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yourchari_app/constants/othes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourchari_app/constants/string.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

final profileNotifierProvider =
    ChangeNotifierProvider(((ref) => ProfileController()));

class ProfileController extends ChangeNotifier {
  File? croppedFile;
  Uint8List? compressData;
  MainController mainController = MainController();
  Future<String> uploadImageAndGetURL(
      {required String uid, required Uint8List file}) async {
    //uuid
    final String fileName = returnFileName();

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putData(file);
    // users/uid/ファイル名 のURLを取得
    return storageRef.getDownloadURL();
  }

  Future<void> uploadImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    // デバイスから画像を取得
    final XFile? xFile = await returnXFile();
    final String uid = currentUserDoc.id;
    //　写真選択のキャンセルの場合はreturn
    if (xFile == null) {
      return;
    }
    // xfileを元にc編集されたcroppedFileを取得
    croppedFile = await returnCroppedFile(xFile: xFile, ratioX: 1, ratioY: 1);
    notifyListeners();
    //写真編集の画面でキャンセルの場合はretun
    if (croppedFile == null) {
      return;
    }
    // croppedFileを元にcompressdataを取得。
    compressData = await returnCompressAndGetData(
        file: croppedFile!, minWidth: 200, minHeight: 200);
    // compreddDataをstorageに投稿、投稿先のURLを取得
    final String url =
        await uploadImageAndGetURL(uid: uid, file: compressData!);
    // ユーザーのcurrentUmageURlを上記のurlに置換
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
  }

  ProfileController() {
    init();
  }

  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];
  Future<void> init() async {
    startLoading();
    final qshot = await FirebaseFirestore.instance
        .collection('chari')
        .where('uid', isEqualTo: mainController.currentUser!.uid)
        // .orderBy("createdAt", descending: true)
        .get();
    chariDocs = qshot.docs;
    endLoading();
  }

  bool isLoading = false;
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
