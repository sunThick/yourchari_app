import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourchari_app/domain/chari/chari.dart';

import '../constants/othes.dart';
import '../constants/string.dart';

final createChariProvider =
    ChangeNotifierProvider.autoDispose(((ref) => CreateChariModel()));

class CreateChariModel extends ChangeNotifier {
  String category = "single";
  String brand = "";
  String frame = "";
  String caption = "";
  List images = [];
  File? croppedFile;

  final TextEditingController brandEditingController = TextEditingController();
  final TextEditingController frameEditingController = TextEditingController();
  final TextEditingController captionEditingController =
      TextEditingController();

  void onCategoryChanged({required String value}) {
    category = value;
    notifyListeners();
  }

  Future<void> selectImages() async {
    // デバイスから画像を取得

    if (images.length >= 5) {
      return;
    }

    final XFile? xFile = await returnXFile();
    //　写真選択のキャンセルの場合はreturn
    if (xFile == null) {
      return;
    }
    // final String uid = currentUserDoc.id;
    // xfileを元にc編集されたcroppedFileを取得
    croppedFile = await returnCroppedFile(xFile: xFile, ratioX: 4, ratioY: 3);
    //写真編集の画面でキャンセルの場合はretun
    if (croppedFile == null) {
      return;
    }
    images.add(croppedFile);
    notifyListeners();
  }

  Future<void> createChari(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    // firestore
    final chariCollection = FirebaseFirestore.instance.collection('chari');
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final List<String> imageURL = [];
    final Chari chari = Chari(
        category: category,
        brand: brandEditingController.text,
        frame: frameEditingController.text,
        imageURL: imageURL,
        likeCount: 0,
        postId: postId,
        uid: activeUid,
        caption: frameEditingController.text,
        createdAt: now,
        updatedAt: Timestamp.now());

    // storage
    final imageFiles = [];
    //  croppedFileをFileに変換
    for (var element in images) {
      final imageFile = File(element!.path);
      imageFiles.add(imageFile);
    }
    // final File imageFile = File(croppedFile!.path);

    for (var element in imageFiles) {
      final String url =
          await uploadImageAndGetURL(postId: postId, file: element);
      imageURL.add(url);
    }
    await chariCollection.doc(postId).set(chari.toJson());
  }

  // 自転車の写真をfirestorageに投稿 && アップロード先のURLを取得。
  Future<String> uploadImageAndGetURL(
      {required String postId, required File file}) async {
    //uuid
    final String fileName = returnFileName();

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("charis")
        .child(postId)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名 のURLを取得
    return storageRef.getDownloadURL();
  }
}
