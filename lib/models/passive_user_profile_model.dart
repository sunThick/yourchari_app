import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import '../constants/enums.dart';
import '../constants/string.dart';
import '../domain/follower/follower.dart';
import '../domain/following_token/following_token.dart';
import 'main_model.dart';

// final passiveUserProviderFamily =
// // tupleを用いてuserIdからChariとFirestoreUserをreturn
//     FutureProvider.autoDispose.family<
//         Tuple2<FirestoreUser,
//             List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
//         String>(((ref, uid) async {
//   final passiveUserDoc =
//       await FirebaseFirestore.instance.collection('users').doc(uid).get();
//   final passiveUser = FirestoreUser.fromJson(passiveUserDoc.data()!);
//   final qshot = await FirebaseFirestore.instance
//       .collection('chari')
//       .where('uid', isEqualTo: uid)
//       .get();
//   final chariDocs = qshot.docs;
//   final passiveUserAndCharis = Tuple2(passiveUser, chariDocs);
//   return passiveUserAndCharis;
// }));

final passiveUserFamily = StreamProvider.autoDispose.family<
    Tuple2<FirestoreUser,
        List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
    String>(((ref, uid) async* {
  final userStream =
      FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

  final passiveUser =
      userStream.map((event) => FirestoreUser.fromJson(event.data()!));

  await for (final value in passiveUser) {
    final us = value;
    final qshot = await FirebaseFirestore.instance
      .collection('chari')
      .where('uid', isEqualTo: uid)
      .get();
    final chariDocs = qshot.docs;
    yield Tuple2(us, chariDocs);
  }
}));

final passiveUserProvider =
    ChangeNotifierProvider(((ref) => PassiveUserModel()));

class PassiveUserModel extends ChangeNotifier {
  bool isFollowed = false;

  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    // settings
    mainModel.followingUids.add(passiveUser.uid);
    isFollowed = true;
    notifyListeners();
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        createdAt: now,
        passiveUid: passiveUser.uid,
        tokenId: tokenId,
        tokenType: followingTokenTypeString);
    final FirestoreUser activeUser = mainModel.firestoreUser;

    // 自分がフォローした印
    await FirebaseFirestore.instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .doc(tokenId)
        .set(followingToken.toJson());
    // 受動的なユーザーがフォローされたdataを生成する

    final Follower follower = Follower(
        createdAt: now,
        followedUid: passiveUser.uid,
        followerUid: activeUser.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .set(follower.toJson());
    // print(mainModel.followingUids);
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);
    isFollowed = false;
    notifyListeners();
    // followしているTokenを取得する
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // qshotというdataの塊の存在を存在を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .where("passiveUid", isEqualTo: passiveUser.uid)
        .get();
    // 1個しか取得してないけど複数している扱い
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();
    // 受動的なユーザーがフォローされたdataを削除する
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .delete();
  }
}
