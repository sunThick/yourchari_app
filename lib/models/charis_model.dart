import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/string.dart';
import '../domain/chari/chari.dart';
import '../domain/chari_like/chari_like.dart';
import '../domain/like_chari_token/like_chari_token.dart';
import 'main_model.dart';

final charisProvider = ChangeNotifierProvider(
  ((ref) => CharisModel()
));

class CharisModel extends ChangeNotifier{
  Future<void> like({required Chari chari,required DocumentSnapshot<Map<String,dynamic>> chariDoc,required DocumentReference<Map<String,dynamic>> chariRef,required MainModel mainModel}) async {
    // setting
    final String postId = chari.postId;
    mainModel.likeChariIds.add(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = chari.uid;
    notifyListeners();
    // 自分がいいねしたことの印
    final LikeChariToken likeChariToken = LikeChariToken(
      activeUid: activeUid,
      createdAt: now, 
      passiveUid: passiveUid,
      chariRef: chariRef, 
      postId: postId, 
      tokenId: tokenId,
      tokenType: "likeChari"
    );
    await currentUserDoc.reference.collection("tokens").doc(tokenId).set(likeChariToken.toJson());
    // 投稿がいいねされたことの印
    final ChariLike chariLike = ChariLike(
      activeUid: activeUid, 
      createdAt: now,
      passiveUid: passiveUid,
      chariRef: chariRef, 
      postId: postId
    );
    // いいねする人が重複しないようにUidをdocumentIdとする
    await chariRef.collection("chariLikes").doc(activeUid).set(chariLike.toJson());
 
  }
  Future<void> unlike({required Chari chari,required DocumentSnapshot<Map<String,dynamic>> chariDoc,required DocumentReference<Map<String,dynamic>> chariRef,required MainModel mainModel}) async {
    final String postId = chari.postId;
    mainModel.likeChariIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    notifyListeners();
    // 自分がいいねしたことの印を削除
    final QuerySnapshot<Map<String,dynamic>> qshot = await FirebaseFirestore.instance.collection("users").doc(activeUid).collection("tokens").where("postId",isEqualTo: chari.postId).get();
    // 1個しか取得していないけど複数取得している扱い
    final List<DocumentSnapshot<Map<String,dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String,dynamic>> token = docs.first;
    await token.reference.delete();
    // 投稿がいいねされたことの印を削除
    await chariDoc.reference.collection("chariLikes").doc(activeUid).delete();
  }
}