import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';

final chariProviderFamily =
// tupleを用いて自転車のpostIdからChariとFirestoreUserをreturn
    FutureProvider.autoDispose.family<Tuple2<Chari, FirestoreUser>, String>(((ref, uid) async {
  final chariDoc =
      await FirebaseFirestore.instance.collection('chari').doc(uid).get();
  final chari = Chari.fromJson(chariDoc.data()!);
  final userId = chari.uid;
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final passiveUser = FirestoreUser.fromJson(userDoc.data()!);
  final chariAndPassiveUser = Tuple2<Chari, FirestoreUser>(chari, passiveUser);
  return chariAndPassiveUser;
}));

final chariDetailProvider =
    ChangeNotifierProvider.autoDispose(((ref) => ChariDetailModel()));

class ChariDetailModel extends ChangeNotifier {
  var i = 0;

  void tasu({required Chari chari}) {
    print(chari.brand);
    notifyListeners();
  }
}
