import 'package:flutter/material.dart';
import 'package:yourchari_app/constants/othes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  XFile? xfile;

  Future<void> pickImage() async {
    xfile = await returnXFile();
  }
}
