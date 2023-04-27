import 'package:flutter/material.dart';
import 'package:yourchari_app/details/circle_image.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key? key, required this.length, required this.userImageURL})
      : super(key: key);
  final double length;
  final String userImageURL;

  @override
  Widget build(BuildContext context) {
    // 与えられたUserImageURLが空のときに表示する
    return userImageURL.isEmpty
        ? Container(
            width: length,
            height: length,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                shape: BoxShape.circle),
            child: Icon(
              Icons.person,
              size: length,
            ))
        : CircleImage(length: length, image: NetworkImage(userImageURL));
  }
}
