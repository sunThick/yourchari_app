import 'package:flutter/material.dart';

class DefaultUserImage extends StatelessWidget {
  const DefaultUserImage({Key? key, required this.length}) : super(key: key);
  final double length;

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(Icons.person),
    );
  }
}


