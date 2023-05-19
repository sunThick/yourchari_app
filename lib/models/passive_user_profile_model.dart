import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';

final passiveUserProviderFamily =
// tupleを用いてuserIdからChariとFirestoreUserをreturn
    FutureProvider.autoDispose.family<
        Tuple2<FirestoreUser,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
        String>(((ref, uid) async {
  final passiveUserDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final passiveUser = FirestoreUser.fromJson(passiveUserDoc.data()!);
  final qshot = await FirebaseFirestore.instance
      .collection('chari')
      .where('uid', isEqualTo: uid)
      .get();
  final chariDocs = qshot.docs;
  final passiveUserAndCharis = Tuple2(passiveUser, chariDocs);
  return passiveUserAndCharis;
}));

final passiveUserProvider =
    ChangeNotifierProvider.autoDispose(((ref) => PassiveUserModel()));

class PassiveUserModel extends ChangeNotifier {


}
