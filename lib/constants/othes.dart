// intとかString以外のものreturn
// package
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: const AndroidUiSettings(),
      iosUiSettings: const IOSUiSettings());
  return result;
}
