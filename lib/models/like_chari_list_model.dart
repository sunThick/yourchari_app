import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../domain/like_chari_token/like_chari_token.dart';

final likeChariDocsProvider =
    FutureProvider.family<Tuple2<List<DocumentSnapshot<Map<String, dynamic>>>, List<DocumentSnapshot<Map<String, dynamic>>>> , String>(
        ((ref, uid) async {
  final MainController mainController = ref.watch(mainProvider);
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
  List<DocumentSnapshot<Map<String, dynamic>>> passiveUserDocs = [];

  for (final likeChariTokenDoc in likeChariTokenDocs) {
    final LikeChariToken likeChariToken =
        LikeChariToken.fromJson(likeChariTokenDoc.data());
    if (!mainController.muteUids.contains(likeChariToken.passiveUid)) {
      final likedChariDoc = await FirebaseFirestore.instance
          .collection("chari")
          .doc(likeChariToken.postId)
          .get();
      final passiveUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(likeChariToken.passiveUid)
          .get();

      likeChariDocs.add(likedChariDoc);
      passiveUserDocs.add(passiveUserDoc);
    }
  }

  return Tuple2(likeChariDocs, passiveUserDocs);
}));
