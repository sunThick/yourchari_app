import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';

final chariProviderFamily = FutureProvider.autoDispose
    .family<Map<String, dynamic>?, String>(((ref, uid) async {
  return await ChariDetailModel(uid: uid).init(uid: uid);
}));

class ChariDetailModel extends ChangeNotifier {
  ChariDetailModel({required String uid}) {
    init(uid: uid);
  }

  Future<Map<String, dynamic>?> init({required String uid}) async {
    startLoading();
    final chariDoc =
        await FirebaseFirestore.instance.collection('chari').doc(uid).get();
    endLoading();
    return chariDoc.data();
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
