import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../domain/firestore_user/firestore_user.dart';
import '../domain/following_token/following_token.dart';

final followersOrFollowsNotifierProvider =
    ChangeNotifierProvider(((ref) => FollowersAndFollowsController()));

class FollowersAndFollowsController extends ChangeNotifier {
  bool isLoading = false;
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }



  Future<void> onLoading(
      {required List<DocumentSnapshot<Map<String, dynamic>>> userDocs,
      required String followingOrFollowers,
      required String userUid,
      required MainController mainController
      ,required refreshController}) async {
    startLoading();
    refreshController.loadComplete();
    // final lastDoc = userDocs.last;

    if (userDocs.isNotEmpty) {
      final FirestoreUser fireLastUser =
          FirestoreUser.fromJson(userDocs.last.data()!);
      if (followingOrFollowers == "followers") {
        final lastFollowerQshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("followers")
            .where("followerUid", isEqualTo: fireLastUser.uid)
            .get();
        final lastFollowerDoc = lastFollowerQshot.docs.first;
        final followersQshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("followers")
            .orderBy("createdAt", descending: true)
            .startAfterDocument(lastFollowerDoc)
            .limit(10)
            .get();
        final followersDocs = followersQshot.docs;
        for (final followerDoc in followersDocs) {
          //  muteしているユーザーは追加しない
          if (!mainController.muteUids.contains(followerDoc.id)) {
            final oldFollowerDoc = await FirebaseFirestore.instance
                .collection("users")
                .doc(followerDoc.id)
                .get();
            userDocs.add(oldFollowerDoc);
          }
        }
      }
      if (followingOrFollowers == "following") {
        final lastFolloingTokens = await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("tokens")
            .where('passiveUid', isEqualTo: fireLastUser.uid)
            .where('tokenType', isEqualTo: "following")
            .get();
        final lastFollowingToken = lastFolloingTokens.docs.first;
        final oldFollowingQshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('tokens')
            .where('tokenType', isEqualTo: "following")
            .orderBy("createdAt", descending: true)
            .startAfterDocument(lastFollowingToken)
            .limit(10)
            .get();

        final oldFollowingDocs = oldFollowingQshot.docs;
        for (final oldFollowingDoc in oldFollowingDocs) {
          //  muteしているユーザーは追加しない
          final FollowingToken followingToken =
              FollowingToken.fromJson(oldFollowingDoc.data());
          if (!mainController.muteUids.contains(followingToken.passiveUid)) {
            final userQshot = await FirebaseFirestore.instance
                .collection('users')
                .doc(followingToken.passiveUid)
                .get();
            userDocs.add(userQshot);
          }
        }
      }
    }
    endLoading();
  }
}
