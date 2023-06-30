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

final passiveUserChariProvider = FutureProvider.autoDispose.family<
    List<DocumentSnapshot<Map<String, dynamic>>>,
    Tuple2<String, String>>(((ref, data) async {
  final MainController mainController = ref.watch(mainProvider);
  final uid = data.item1;
  final chariOrLikes = data.item2;
  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];
  if (chariOrLikes == 'chari') {
    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .where('uid', isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();
    chariDocs = chariQshot.docs;
  } else if (chariOrLikes == 'likes') {
    final likeChariTokenQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tokens")
        .where("tokenType", isEqualTo: "likeChari")
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();
    final likeChariTokenDocs = likeChariTokenQshot.docs;
    for (final likeChariTokenDoc in likeChariTokenDocs) {
      final LikeChariToken likeChariToken =
          LikeChariToken.fromJson(likeChariTokenDoc.data());
      final likedChariDoc = await FirebaseFirestore.instance
          .collection("chari")
          .doc(likeChariToken.postId)
          .get();
      chariDocs.add(likedChariDoc);
    }
  }
  chariDocs = chariWithoutMuteUser(chariDocs: chariDocs, mainController: mainController);
  return chariDocs;
}));

// final passiveUserChariDocsProvider = FutureProvider.family<
//     List<DocumentSnapshot<Map<String, dynamic>>>,
//     Tuple2<String, String>>(((ref, t2) async {
//   final String uid = t2.item1;
//   final String chariOrLikes = t2.item2;

//   final usercharisQshot = await FirebaseFirestore.instance
//       .collection('chari')
//       .where('uid', isEqualTo: uid)
//       .orderBy("createdAt", descending: true)
//       .limit(10)
//       .get();
//   final likeChariTokenQshot = await FirebaseFirestore.instance
//       .collection("users")
//       .doc(uid)
//       .collection("tokens")
//       .where("tokenType", isEqualTo: "likeChari")
//       .orderBy("createdAt", descending: true)
//       .limit(10)
//       .get();
//   final likeChariTokenDocs = likeChariTokenQshot.docs;

//   List<DocumentSnapshot<Map<String, dynamic>>> likeChariDocs = [];

//   for (final likeChariTokenDoc in likeChariTokenDocs) {
//     // if(likeChariTokenDoc.data() != null)
//     final LikeChariToken likeChariToken =
//         LikeChariToken.fromJson(likeChariTokenDoc.data());
//     final likedChariDoc = await FirebaseFirestore.instance
//         .collection("chari")
//         .doc(likeChariToken.postId)
//         .get();
//     likeChariDocs.add(likedChariDoc);
//   }

//   final userchariDocs = usercharisQshot.docs;

//   List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];

//   if (chariOrLikes == "chari") {
//     chariDocs = userchariDocs;
//   } else {
//     chariDocs = likeChariDocs;
//   }

//   return chariDocs;
// }));
