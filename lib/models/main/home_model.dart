import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider(((ref) => HomeModel()));

class HomeModel extends ChangeNotifier {
  // フォローしているユーザーの投稿の取得に使用する
  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];

  HomeModel() {
    init();
  }

  Future<void> init() async {
    startLoading();
    final qshot = await FirebaseFirestore.instance
        // .collection('users')
        // .doc(currentUser!.uid)
        .collection('chari')
        .orderBy("createdAt", descending: true)
        .limit(30)
        .get();
    chariDocs = qshot.docs;
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