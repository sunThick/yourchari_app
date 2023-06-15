// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';

import '../constants/enums.dart';
import '../domain/following_token/following_token.dart';
import '../domain/like_chari_token/like_chari_token.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainController());

class MainController extends ChangeNotifier {
  bool isLoading = false;
  User? currentUser;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser currentFirestoreUser;
  List<String> followingUids = [];
  List<FollowingToken> followingTokens = [];
  List<String> likeChariIds = [];
  List<LikeChariToken> likeChariTokens = [];

  MainController() {
    init();
  }

  Future<void> init() async {
    startLoading();
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    //上記のdocumentsnapshotでデータを参照、取得
    currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    //classの形にして呼び出せるようにする  firestoreUser.____
    distributeTokens();
    currentFirestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    endLoading();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> distributeTokens() async {
    final tokensQshot =
        await currentUserDoc.reference.collection("tokens").get();
    final tokenDocs = tokensQshot.docs;
    // 新しい順に並べる
    // 公式的なもの。
    // 古い順に並べるなら、aとbを逆にする
    tokenDocs.sort(
        (a, b) => (b["createdAt"] as Timestamp).compareTo(a["createdAt"]));
    for (final token in tokenDocs) {
      final Map<String, dynamic> tokenMap = token.data();
      // Stringからenumに変換してミスのないように
      final TokenType tokenType = mapToTokenType(tokenMap: tokenMap);
      switch (tokenType) {
        case TokenType.following:
          final FollowingToken followingToken =
              FollowingToken.fromJson(tokenMap);
          followingTokens.add(followingToken);
          followingUids.add(followingToken.passiveUid);
          break;
        case TokenType.likeChari:
          final LikeChariToken likeChariToken =
              LikeChariToken.fromJson(tokenMap);
          likeChariTokens.add(likeChariToken);
          likeChariIds.add(likeChariToken.postId);
          break;
      }
    }
  }
}