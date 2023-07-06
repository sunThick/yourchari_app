import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/like_chari_token/like_chari_token.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../constants/void.dart';

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

final passiveUserLikeChariDocsProvider =
    FutureProvider.family<List<DocumentSnapshot<Map<String, dynamic>>>, String>(
        ((ref, uid) async {
  final likeChariTokenQshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("tokens")
      .where("tokenType", isEqualTo: "likeChari")
      .orderBy("createdAt", descending: true)
      .limit(10)
      .get();
  final likeChariTokenDocs = likeChariTokenQshot.docs;

  List<DocumentSnapshot<Map<String, dynamic>>> likeChariDocs = [];

  for (final likeChariTokenDoc in likeChariTokenDocs) {
    final LikeChariToken likeChariToken =
        LikeChariToken.fromJson(likeChariTokenDoc.data());
    final likedChariDoc = await FirebaseFirestore.instance
        .collection("chari")
        .doc(likeChariToken.postId)
        .get();
    likeChariDocs.add(likedChariDoc);
  }

  return likeChariDocs;
}));
