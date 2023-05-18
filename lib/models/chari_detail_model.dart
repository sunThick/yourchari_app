import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';

// final chariDetailProvider =
//     ChangeNotifierProvider(((ref) => ChariDetailModel(uid: '')));

// final chariDetailProvider =

// final chariProviderFamily = FutureProvider.autoDispose
//     .family<ChariDetailModel, String>(((ref, uid) async {
//   return ChariDetailModel(uid: uid);
// }));

final chariProviderFamily = FutureProvider.autoDispose.family <DocumentSnapshot<Map<String, dynamic>>, String>(((ref, uid) async {
      return await FirebaseFirestore.instance.collection('chari').doc(uid).get();
    }));

// final detailPageProviderFamily =
//     FutureProvider.family<ChariDetailModel, String>((ref, uid) {
//   return ChariDetailModel(uid: uid);
// });

class ChariDetailModel extends ChangeNotifier {
  // ChariDetailModel({required String uid});
  ChariDetailModel({required String uid}) {
    init(uid: uid);
  }

  // CartPageStateNotifier.init({required Cart cart}) : super(cart);
  // ChariDetailModel.init({required String uid});

  Future<void> init({required String uid}) async {
    // startLoading();
    final chariDoc =
        await FirebaseFirestore.instance.collection('chari').doc(uid).get();

    // print(chariDoc.data());
    // endLoading();
  }

  // bool isLoading = false;
  // void startLoading() {
  //   isLoading = true;
  //   notifyListeners();
  // }

  // void endLoading() {
  //   isLoading = false;
  //   notifyListeners();
  // }
}
