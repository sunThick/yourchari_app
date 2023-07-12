import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final passiveUserProvider = FutureProvider.autoDispose
    .family<DocumentSnapshot<Map<String, dynamic>>, String>(((ref, uid) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return userDoc;
}));

final passiveUserChariDocsProvider =
    FutureProvider.family<List<DocumentSnapshot<Map<String, dynamic>>>, String>(
        ((ref, uid) async {
  final usercharisQshot = await FirebaseFirestore.instance
      .collection('chari')
      .where('uid', isEqualTo: uid)
      .orderBy("createdAt", descending: true)
      .limit(10)
      .get();

  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = usercharisQshot.docs;

  return chariDocs;
}));


