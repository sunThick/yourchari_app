import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/follower/follower.dart';
import 'package:yourchari_app/domain/following_token/following_token.dart';
import '../domain/firestore_user/firestore_user.dart';

final followersOrFollowsFamily = FutureProvider.autoDispose.family<
    Tuple2<
      List<DocumentSnapshot<Map<String, dynamic>>>,
      QueryDocumentSnapshot<Map<String, dynamic>>>,
    Tuple2<String, String>>(((ref, state) async {
  final String uid = state.item1;
  final String followingOrFollowers = state.item2;
  List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> lastDocs = [];

  if (followingOrFollowers == "followers") {
    final followersQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();
    final followersDocs = followersQshot.docs;
    lastDocs.add(followersDocs.first);
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
        .limit(10)
        .get();

    final followsDocs = followsQshot.docs;
    lastDocs.add(followsDocs.first);
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
  final lastDoc = lastDocs.first;
  final userDocsAndLastDoc = Tuple2<
      List<DocumentSnapshot<Map<String, dynamic>>>,
      QueryDocumentSnapshot<Map<String, dynamic>>>(userDocs, lastDoc);
  return userDocsAndLastDoc;
}));

final followersAndFollowsProvider =
    ChangeNotifierProvider(((ref) => FollowersAndFollowsModel()));

class FollowersAndFollowsModel extends ChangeNotifier {
  bool isLoading = false;
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  final RefreshController refreshController = RefreshController();

  Future<void> onLoading(
      {required List<DocumentSnapshot<Map<String, dynamic>>> userDocs,
      required String followingOrFollowers,
      required String userUid,
      required QueryDocumentSnapshot<Map<String, dynamic>> lastDoc}) async {
    startLoading();
    refreshController.loadComplete();
    final lastDoc = userDocs.last;
    if (userDocs.isNotEmpty) {
      if (followingOrFollowers == "followers") {
        final followersQshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("followers")
            .orderBy("createdAt", descending: true)
            .startAfterDocument(lastDoc)
            .limit(10)
            .get();
        final followersDocs = followersQshot.docs;
        for (final followerDoc in followersDocs) {
          // Follower follower = Follower.fromJson(followerDoc.data());
          final oldFollowerDoc = await FirebaseFirestore.instance
              .collection("users")
              .doc(followerDoc.id)
              .get();
          userDocs.add(oldFollowerDoc);
        }
      }
      if (followingOrFollowers == "following") {
        final followsQshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('tokens')
            .where('tokenType', isEqualTo: "following")
            .orderBy("createdAt", descending: true)
            .startAfterDocument(lastDoc)
            .limit(10)
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
    }
    endLoading();
  }
}
