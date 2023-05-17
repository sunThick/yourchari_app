import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/chari/chari.dart';

import '../domain/firestore_user/firestore_user.dart';



final passiveUserProfileProvider =
    ChangeNotifierProvider((ref) => PassiveUserProfileModel());

class PassiveUserProfileModel extends ChangeNotifier {


  PassiveUserProfileModel() {
    init();
  }

  Future<void> init() async {
    startLoading();
    //上記のdocumentsnapshotでデータを参照、取得
    final currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('uid')
        .get();
    //classの形にして呼び出せるようにする  firestoreUser.____
    final firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    endLoading();
  }

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
