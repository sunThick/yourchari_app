import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/chari/chari.dart';

import '../constants/string.dart';
import 'main_model.dart';

final createChariProvider =
    ChangeNotifierProvider(((ref) => CreateChariModel()));

class CreateChariModel extends ChangeNotifier {
  String category = "single";
  String brand = "";
  String frame = "";
  String caption = "";

  final TextEditingController brandEditingController = TextEditingController();
  final TextEditingController frameEditingController = TextEditingController();
  final TextEditingController captionEditingController =
      TextEditingController();

  void onCategoryChanged({required String value}) {
    category = value;
    notifyListeners();
  }

  final chariCollection = FirebaseFirestore.instance.collection('chari');

  Future<void> createChari(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final chariCollection = FirebaseFirestore.instance.collection('chari');
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Chari chari = Chari(
        category: category,
        brand: brandEditingController.text,
        frame: frameEditingController.text,
        imageURL: [],
        likeCount: 0,
        postId: postId,
        uid: activeUid,
        caption: frameEditingController.text,
        createdAt: now,
        updatedAt: Timestamp.now());

    await chariCollection.doc(postId).set(chari.toJson());
  }

  Future<void> createPost(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Chari chari = Chari(
        category: category,
        brand: brandEditingController.text,
        frame: frameEditingController.text,
        imageURL: [],
        likeCount: 0,
        postId: postId,
        uid: activeUid,
        caption: frameEditingController.text,
        createdAt: now,
        updatedAt: Timestamp.now());
    await currentUserDoc.reference
        .collection("chari")
        .doc(postId)
        .set(chari.toJson());
    print(chari);
  }
}
