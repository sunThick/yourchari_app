import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/follower/follower.dart';
import 'package:yourchari_app/domain/following_token/following_token.dart';

final followersOrFollowsProvider = FutureProvider.autoDispose.family<
    List<DocumentSnapshot<Map<String, dynamic>>>,
    Tuple2<String, String>>(((ref, state) async {
  final String uid = state.item1;
  final String followingOrFollowers = state.item2;
  List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];

  if (followingOrFollowers == "followers") {
    final followersQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .orderBy("createdAt", descending: true)
        .limit(15)
        .get();
    final followersDocs = followersQshot.docs;
    for (final followerDoc in followersDocs) {
      Follower follower = Follower.fromJson(followerDoc.data());
      final followerQshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(follower.followerUid)
          .get();
      userDocs.add(followerQshot);
    }
  }
  if (followingOrFollowers == "following") {
    final followsQshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .where('tokenType', isEqualTo: "following")
        .orderBy("createdAt", descending: true)
        .limit(15)
        .get();

    final followsDocs = followsQshot.docs;
    for (final follow in followsDocs) {
      final FollowingToken followingToken =
          FollowingToken.fromJson(follow.data());
      final userQshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(followingToken.passiveUid)
          .get();
      userDocs.add(userQshot);
    }
  }
  return userDocs;
}));
