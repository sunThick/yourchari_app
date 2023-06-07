import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/follower/follower.dart';
import 'package:yourchari_app/domain/following_token/following_token.dart';
import '../domain/firestore_user/firestore_user.dart';

final followersOrFollowsFamily = FutureProvider.autoDispose
    .family<List<FirestoreUser>, Tuple2<String, String>>(((ref, state) async {
  List<FirestoreUser> followersOrFollows = [];
  final String uid = state.item1;
  final String followOrFollowing = state.item2;

  if (followOrFollowing == "followers") {
    final followersQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .limit(20)
        .get();
    final followersDocs = followersQshot.docs;
    for (final followerDoc in followersDocs) {
      Follower follower = Follower.fromJson(followerDoc.data());
      final followerQshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(follower.followerUid)
          .get();
      FirestoreUser user = FirestoreUser.fromJson(followerQshot.data()!);
      followersOrFollows.add(user);
    }
  }
  if (followOrFollowing == "following") {
    final followsQshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .where('tokenType', isEqualTo: "following")
        .get();
    print(followsQshot);
    final followsDocs = followsQshot.docs;
    for (final follow in followsDocs) {
      final FollowingToken followingToken =
          FollowingToken.fromJson(follow.data());
      final userQshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(followingToken.passiveUid)
          .get();
      final FirestoreUser followUser =
          FirestoreUser.fromJson(userQshot.data()!);
      followersOrFollows.add(followUser);
    }
  }

  return followersOrFollows;
}));
