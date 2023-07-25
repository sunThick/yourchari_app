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

  String caption = "";
  List<File> images = [];
  File? croppedFile;
  File? compressedfile;
  Uint8List? compress;
  bool isCreating = false;
  bool isCreated = false;
  bool isDeleting = false;
  bool isDeleted = false;
  bool requireImage = false;
  bool requireCategory = false;
  bool requireBrand = false;
  bool requireFrame = false;
  int brandEditingCounter = 0;
  int frameEditingCounter = 0;

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

  Future<void> endCreating({required context}) async {
    isCreated = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
  }

  void startDeleting() {
    isDeleting = true;
    notifyListeners();
  }

  Future<void> endDeleting({required context}) async {
    isDeleted = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
  }

// viewから渡されたstringを元にclassを作成
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

  //  カテゴリー選択時の動作
  void onCategoryChanged({required String value}) {
    category = value;
    notifyListeners();
  }

  // imagesの順番が入れ替わった時の動作
  void onImagesListChange({required oldIndex, required newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = images.removeAt(oldIndex);
    images.insert(newIndex, item);
  }

//  imagesが削除された時の動作
  void deleteListImage({required image}) {
    images.remove(image);
    notifyListeners();
  }

// imagepicker から画像を取得し、そのままcroppedで比率を固定。
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

// バリデーションエラーの後、、入力を完了するとエラーをなくす
  void textFieldIsFilled({required String title}) {
    if (title == "brand") {
      requireBrand = false;
    } else if (title == "frame") {
      requireFrame = false;
    }
    notifyListeners();
  }

//  上記の後、再びisEmptyになった場合、バリデーションエラーを出す。
  void reRequired({required String title}) {
    if (title == "brand") {
      requireBrand = true;
    } else if (title == "frame") {
      requireFrame = true;
    }
    notifyListeners();
  }

// 投稿前のバリデーション
  bool validation() {
    requireImage = false;
    requireCategory = false;
    requireBrand = false;
    requireFrame = false;

    frameBrandEditingController.text = frameBrandEditingController.text.trim();
    frameNameEditingController.text = frameNameEditingController.text.trim();

    if (images.isEmpty ||
        category == "" ||
        frameBrandEditingController.text == "" ||
        frameNameEditingController.text == "") {
      if (images.isEmpty) {
        requireImage = true;
      }
      if (category == "") {
        requireCategory = true;
      }
      if (frameBrandEditingController.text.isEmpty) {
        requireBrand = true;
      }
      if (frameNameEditingController.text.isEmpty) {
        requireFrame = true;
      }
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  Future<void> createChari(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required context}) async {
    startCreating();
    // firestore
    final chariCollection = FirebaseFirestore.instance.collection('chari');
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final List<String> imageURL = [];
    final List<Uint8List> compressImages = [];

    Chari chari = Chari(
      category: category,
      brand: frameBrandEditingController.text.trim(),
      frame: frameNameEditingController.text.trim(),
      imageURL: imageURL,
      likeCount: 0,
      postId: postId,
      uid: activeUid,
      caption: captionEditingController.text.trim(),
      createdAt: now,
      updatedAt: Timestamp.now(),
    );

    //  パーツをセット
    chari = setPartsChari(
        partsTextEditingControllerList: partsTextEditingControllerList,
        chari: chari);

    //  imagesを圧縮
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
    endCreating(context: context);
  }

  /// chariを削除----------------------------------------------------------------

  Future<void> deleteChari({required Chari chari, required context}) async {
    startDeleting();
    await FirebaseFirestore.instance
        .collection('chari')
        .doc(chari.postId)
        .delete();
    for (final imageURL in chari.imageURL) {
      final storageReference = FirebaseStorage.instance.refFromURL(imageURL);
      await storageReference.delete();
    }
    await endDeleting(context: context);
    showToast(msg: 'chariを削除しました');
    Navigator.of(context).pop();
  }

  ///   パーツをセットし、chariをreturnする関数
  Chari setPartsChari(
      {required List<FormChariText> partsTextEditingControllerList,
      required Chari chari}) {
    for (FormChariText formChariText in partsTextEditingControllerList) {
      if (formChariText.part == "fork") {
        chari = chari.copyWith(fork: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "headSet") {
        chari = chari.copyWith(headSet: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "columnSpacer") {
        chari = chari.copyWith(columnSpacer: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "handleBar") {
        chari = chari.copyWith(handleBar: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "stem") {
        chari = chari.copyWith(stem: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "grip") {
        chari = chari.copyWith(grip: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "saddle") {
        chari = chari.copyWith(saddle: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "seatPost") {
        chari = chari.copyWith(seatPost: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "seatClamp") {
        chari = chari.copyWith(seatClamp: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "tire") {
        chari = chari.copyWith(tire: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "rim") {
        chari = chari.copyWith(rim: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "hub") {
        chari = chari.copyWith(hub: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "cog") {
        chari = chari.copyWith(cog: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "sprocket") {
        chari = chari.copyWith(sprocket: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "lockRing") {
        chari = chari.copyWith(lockRing: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "freeWheel") {
        chari = chari.copyWith(freeWheel: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "crank") {
        chari = chari.copyWith(crank: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "chainRing") {
        chari = chari.copyWith(chainRing: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "chain") {
        chari = chari.copyWith(chain: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "bottomBrancket") {
        chari = chari.copyWith(bottomBrancket: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "pedals") {
        chari = chari.copyWith(pedals: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "brake") {
        chari = chari.copyWith(brake: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "brakeLever") {
        chari = chari.copyWith(brakeLever: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "shifter") {
        chari = chari.copyWith(shifter: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "shiftLever") {
        chari = chari.copyWith(shiftLever: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "rack") {
        chari = chari.copyWith(rack: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "bottle") {
        chari = chari.copyWith(bottle: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "frontLight") {
        chari = chari.copyWith(frontLight: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "rearLight") {
        chari = chari.copyWith(rearLight: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "lock") {
        chari = chari.copyWith(lock: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "bell") {
        chari = chari.copyWith(bell: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "helmet") {
        chari = chari.copyWith(helmet: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "bag") {
        chari = chari.copyWith(bag: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      } else if (formChariText.part == "basket") {
        chari = chari.copyWith(basket: [
          formChariText.brandEditingController.text.trim(),
          formChariText.nameEditingController.text.trim()
        ]);
      }
    }
    return chari;
  }
}
