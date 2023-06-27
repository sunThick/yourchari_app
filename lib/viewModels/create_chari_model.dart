import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:yourchari_app/domain/form_chari_text/form_chari_text.dart';
import '../constants/othes.dart';
import '../constants/string.dart';

final createChariProvider =
    ChangeNotifierProvider.autoDispose(((ref) => CreateChariController()));

class CreateChariController extends ChangeNotifier {
  ///chari
  String category = "";
  String brand = "";
  String frame = "";
  String caption = "";
  List<File> images = [];
  File? croppedFile;
  File? compressedfile;
  Uint8List? compress;
  bool isCreating = false;
  final TextEditingController frameBrandEditingController =
      TextEditingController();
  final TextEditingController frameNameEditingController =
      TextEditingController();
  final TextEditingController captionEditingController =
      TextEditingController();
  List<FormChariText> partsTextEditingControllerList = [];
  List<String> partsFormList = [];

  void startCreating() {
    isCreating = true;
    notifyListeners();
  }

  void endCreating() {
    isCreating = false;
    notifyListeners();
  }

// viewから渡されたstringを元に
  void addPartsForm({required String part}) {
    if (!partsFormList.contains(part)) {
      partsFormList.add(part);
      TextEditingController brandEditingController = TextEditingController();
      TextEditingController nameEditingController = TextEditingController();
      final editingController = FormChariText(
        part: part,
        brandEditingController: brandEditingController,
        nameEditingController: nameEditingController,
      );
      partsTextEditingControllerList.add(editingController);
      notifyListeners();
    } else {
      partsFormList.remove(part);
      partsTextEditingControllerList
          .removeWhere(((element) => element.part == part));
      notifyListeners();
    }
  }

//----スライドで削除する時の動作
  void removePartsForm(
      {required FormChariText partsFormTextEditingController}) {
    partsTextEditingControllerList.remove(partsFormTextEditingController);
    partsFormList.remove(partsFormTextEditingController.part);
    notifyListeners();
  }

  void onCategoryChanged({required String value}) {
    category = value;
    notifyListeners();
  }

  void onImagesListChange({required oldIndex, required newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = images.removeAt(oldIndex);
    images.insert(newIndex, item);
  }

  void deleteListImage({required image}) {
    images.remove(image);
    notifyListeners();
  }

  Future<void> selectImages() async {
    // デバイスから画像を取得
    final XFile? xFile = await returnXFile();
    //　写真選択のキャンセルの場合はreturn
    if (xFile == null) {
      return;
    }
    // xfileを元にc編集されたcroppedFileを取得
    croppedFile = await returnCroppedFile(xFile: xFile, ratioX: 4, ratioY: 3);
    //写真編集の画面でキャンセルの場合はretun
    if (croppedFile == null) {
      return;
    }
    // viewで選択画像を表示するためにimagesに追加
    images.add(croppedFile!);
    notifyListeners();
  }

  // 自転車の写真をfirestorageに投稿 && アップロード先のURLを取得。
  Future<String> uploadImageAndGetURL(
      {required String postId, required Uint8List compress}) async {
    //uuid
    final String fileName = returnFileName();

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("charis")
        .child(postId)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putData(compress);
    // users/uid/ファイル名 のURLを取得
    return storageRef.getDownloadURL();
  }

  Future<void> createChari(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    startCreating();
    // firestore
    final chariCollection = FirebaseFirestore.instance.collection('chari');
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final List<String> imageURL = [];
    final List<Uint8List> compressImages = [];
    for (final part in partsTextEditingControllerList) {
      part.part;
    }
    Chari chari = Chari(
      category: category,
      brand: frameBrandEditingController.text,
      frame: frameNameEditingController.text,
      imageURL: imageURL,
      likeCount: 0,
      postId: postId,
      uid: activeUid,
      caption: frameNameEditingController.text,
      createdAt: now,
      updatedAt: Timestamp.now(),
    );
    for (final formChariText in partsTextEditingControllerList) {
      if (formChariText.part == "fork") {
        chari = chari.copyWith(fork: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "headSet") {
        chari = chari.copyWith(headSet: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "columnSpacer") {
        chari = chari.copyWith(columnSpacer: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "handleBar") {
        chari = chari.copyWith(handleBar: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "stem") {
        chari = chari.copyWith(stem: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "grip") {
        chari = chari.copyWith(grip: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "saddle") {
        chari = chari.copyWith(saddle: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "seatPost") {
        chari = chari.copyWith(seatPost: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "seatClamp") {
        chari = chari.copyWith(seatClamp: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "tire") {
        chari = chari.copyWith(tire: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "rim") {
        chari = chari.copyWith(rim: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "hub") {
        chari = chari.copyWith(hub: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "cog") {
        chari = chari.copyWith(cog: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "sprocket") {
        chari = chari.copyWith(sprocket: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "lockRing") {
        chari = chari.copyWith(lockRing: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "freeWheel") {
        chari = chari.copyWith(freeWheel: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "crank") {
        chari = chari.copyWith(crank: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "chainRing") {
        chari = chari.copyWith(chainRing: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "chain") {
        chari = chari.copyWith(chain: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "bottomBrancket") {
        chari = chari.copyWith(bottomBrancket: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "pedals") {
        chari = chari.copyWith(pedals: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "brake") {
        chari = chari.copyWith(brake: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "brakeLever") {
        chari = chari.copyWith(brakeLever: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "shifter") {
        chari = chari.copyWith(shifter: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "shiftLever") {
        chari = chari.copyWith(shiftLever: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "rack") {
        chari = chari.copyWith(rack: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "bottle") {
        chari = chari.copyWith(bottle: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "frontLight") {
        chari = chari.copyWith(frontLight: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "rearLight") {
        chari = chari.copyWith(rearLight: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "lock") {
        chari = chari.copyWith(lock: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "bell") {
        chari = chari.copyWith(bell: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "helmet") {
        chari = chari.copyWith(helmet: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "bag") {
        chari = chari.copyWith(bag: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      } else if (formChariText.part == "basket") {
        chari = chari.copyWith(basket: [
          formChariText.brandEditingController.text,
          formChariText.nameEditingController.text
        ]);
      }
    }

    for (var element in images) {
      compress = await returnCompressAndGetData(
          file: element, minWidth: 600, minHeight: 450);
      compressImages.add(compress!);
    }
    for (var element in compressImages) {
      final String url =
          await uploadImageAndGetURL(postId: postId, compress: element);
      imageURL.add(url);
    }

    chariCollection.doc(postId).set(chari.toJson());
    endCreating();
  }
}
