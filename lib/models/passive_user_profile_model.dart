import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/domain/like_chari_token/like_chari_token.dart';
import '../constants/enums.dart';
import '../constants/string.dart';
import '../domain/follower/follower.dart';
import '../domain/following_token/following_token.dart';
import 'main_model.dart';

final passiveUserFamily = FutureProvider.autoDispose
    .family<DocumentSnapshot<Map<String, dynamic>>, String>(((ref, uid) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return userDoc;
}));

final chariDocsFamily =
    FutureProvider.family<dynamic, Tuple2<String, String>>(((ref, t2) async {
  final String uid = t2.item1;
  final String chariOrLikes = t2.item2;

  final usercharisQshot = await FirebaseFirestore.instance
      .collection('chari')
      .where('uid', isEqualTo: uid)
      .orderBy("createdAt", descending: true)
      .limit(10)
      .get();
  final likeChariTokenQshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("tokens")
      .where("tokenType", isEqualTo: "likeChari")
      .orderBy("createdAt", descending: true)
      .limit(10)
      .get();
  final likeChariTokenDocs = likeChariTokenQshot.docs;

  dynamic likeChariDocs = [];

  for (final likeChariTokenDoc in likeChariTokenDocs) {
    final LikeChariToken likeChariToken =
        LikeChariToken.fromJson(likeChariTokenDoc.data());
    final likedChariDoc = await FirebaseFirestore.instance
        .collection("chari")
        .doc(likeChariToken.postId)
        .get();
    likeChariDocs.add(likedChariDoc);
  }

  final userchariDocs = usercharisQshot.docs;

  dynamic chariDocs = [];

  if (chariOrLikes == "chari") {
    chariDocs = userchariDocs;
  } else {
    chariDocs = likeChariDocs;
  }

  return chariDocs;
}));

final passiveUserProvider =
    ChangeNotifierProvider.autoDispose(((ref) => PassiveUserModel()));

class PassiveUserModel extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(index) {
    currentIndex = index;
    notifyListeners();
  }

  // passiveUserPageに訪れた際、そのuserをfollowしているかどうかで、followersのcountのplusOrMinusを判断
  // userをfollowしている場合、先にunfollowが実行されるためfollowersはminusOne
  // userをfollowしてない場合、先にfollowが実行されるためfollowersはplusOne
  //　先にfollowかunfollowのどちらが実行されたかを知るためにそれぞれが実行された際、followersとunfollowsを += 1する。
  // follows > unfollowの場合、followsが先に実行されるためplusOneがtrueになり、その後unfollowが実行されても,
  // follows > unfollowの時にはminusOneは実行されず、followerCountをそのまま表示できるようにする。
  bool plusOne = false;
  bool minusOne = false;
  int follows = 0;
  int unfollows = 0;

  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.add(passiveUser.uid);
    follows += 1;
    minusOne = false;
    if (follows > unfollows) {
      plusOne = true;
    }
    notifyListeners();
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        createdAt: now,
        passiveUid: passiveUser.uid,
        tokenId: tokenId,
        tokenType: followingTokenTypeString);
    final FirestoreUser activeUser = mainModel.currentFirestoreUser;

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
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);
    unfollows += 1;
    plusOne = false;
    if (unfollows > follows) {
      minusOne = true;
    }
    notifyListeners();
    // followしているTokenを取得する
    final FirestoreUser activeUser = mainModel.currentFirestoreUser;
    // qshotというdataの塊の存在を存在を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .where("passiveUid", isEqualTo: passiveUser.uid)
        .where("tokenType", isEqualTo: "following")
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
