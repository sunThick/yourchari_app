// intとかString以外のものreturn
// package
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

// 写真をギャラリーから読み取り、imageを返す
Future<XFile?> returnXFile() async {
  final ImagePicker picker = ImagePicker();
  // Pick an image
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    return null;
  }
  return image;
}

// xfileからcropeedfileを作成
Future<File?> returnCroppedFile(
    {required XFile? xFile,
    required double ratioX,
    required double ratioY}) async {
  final instance = ImageCropper();
  final File? result = await instance.cropImage(
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      sourcePath: xFile!.path,
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'edit', hideBottomControls: true),
      iosUiSettings: const IOSUiSettings(
        title: 'edit',
        rotateClockwiseButtonHidden: true,
        hidesNavigationBar: true,
        rotateButtonsHidden: true,
      ));
  return result;
}

// croppdefileからcompressDataをreturn
Future<Uint8List> returnCompressAndGetData(
    {required File file, required int minWidth, required int minHeight}) async {
  final result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minHeight: minHeight,
    minWidth: minWidth,
  );
  return result!;
}

DocumentReference<Map<String, dynamic>> currentUserDocToTokenDocRef(
        {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
        required String tokenId}) =>
    currentUserDoc.reference.collection("tokens").doc(tokenId);

showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 16.0);
}
