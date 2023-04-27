// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/details/user_image.dart';
// models
import 'package:yourchari_app/models/main_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen(
      {Key? key, required this.mainModel, required this.userImageURL})
      : super(key: key);
  final MainModel mainModel;
  final String userImageURL;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      child: UserImage(length: 100, userImageURL: '',),
    );
  }
}
