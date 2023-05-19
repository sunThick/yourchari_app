import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';

final chariProviderFamily =
    FutureProvider.autoDispose.family<Chari, String>(((ref, uid) async {
  final chariDoc =
      await FirebaseFirestore.instance.collection('chari').doc(uid).get();
  return Chari.fromJson(chariDoc.data()!);
}));

final chariDetailProvider =
    ChangeNotifierProvider(((ref) => ChariDetailModel()));

class ChariDetailModel extends ChangeNotifier {
  // ChariDetailModel() {

  // }
  
}
