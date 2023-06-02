import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chari/chari.dart';

final homeProvider = ChangeNotifierProvider(((ref) => HomeModel()));

class HomeModel extends ChangeNotifier {
  // フォローしているユーザーの投稿の取得に使用する
  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];
  List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];

  HomeModel() {
    init();
  }

  Future<void> init() async {
    startLoading();

    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .orderBy("createdAt", descending: true)
        .get();
    chariDocs = chariQshot.docs;
    // chariDocsに対応したuidを配列で取得
    final chariUids = chariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();
    // 上記の配列からそれぞれのqshoと取得し、userDocsにaddする
    for (String uid in chariUids) {
      final qshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDocs.add(qshot);
    }

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
