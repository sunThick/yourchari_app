import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../domain/chari/chari.dart';

final homeChariListProvider =
    ChangeNotifierProvider(((ref) => HomeChariListController()));

class HomeChariListController extends ChangeNotifier {
  //category別のchariのからリスト
  // List<DocumentSnapshot<Map<String, dynamic>>> chariDocs = [];
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

  Query<Map<String, dynamic>> returnQuery({required String category}) {
    if (category == 'all') {
      return FirebaseFirestore.instance
          .collection('chari')
          .orderBy("createdAt", descending: true);
    } else {
      return FirebaseFirestore.instance
          .collection('chari')
          .where('category', isEqualTo: category)
          .orderBy("createdAt", descending: true);
    }
  }

  Future<void> onRefresh(chariDocs, userDocs, category) async {
    startLoading();
    refreshController.refreshCompleted();
    if (chariDocs.isNotEmpty) {
      // categoryがallの時は全ての、ではなきはカテゴリーの自転車のクエリーを取得。　　viewからuserdocsを取得し、その一番目より新しい投稿を取得。
      final qshot = await returnQuery(category: category)
          .endBeforeDocument(chariDocs.first)
          .get();
      // desで表示するためreversedにする。
      final reversedChariDocs = qshot.docs.reversed.toList();
      //上記のreversedされたchariのdocのuseruidを配列で取得。
      final chariUids = reversedChariDocs
          .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
          .toList();
      List reversedUserDocs = [];
      //　新しい差分のcharidocsに対応したuserdocsを生成。
      for (String uid in chariUids) {
        final qshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        reversedUserDocs.add(qshot);
      }
      //以下でchariDocs、userDocsの最初にそれぞれを挿入し、最後にv再描画する。
      for (final chariDoc in reversedChariDocs) {
        chariDocs.insert(0, chariDoc);
      }
      for (final userDoc in reversedUserDocs) {
        userDocs.insert(0, userDoc);
      }
    }
    endLoading();
  }

  Future<void> onReload(
      {required String category,
      required dynamic chariDocs,
      required dynamic userDocs}) async {
    startLoading();
    refreshController.refreshCompleted();

    final qshot = await returnQuery(category: category).limit(10).get();
    final newChariDocs = qshot.docs;
    final newChariUids = newChariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();
    List newUserDocs = [];
    for (String uid in newChariUids) {
      final qshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      newUserDocs.add(qshot);
    }
    for (final chariDoc in newChariDocs) {
      chariDocs.add(chariDoc);
    }
    for (final userDoc in newUserDocs) {
      userDocs.add(userDoc);
    }
    endLoading();
  }

  Future<void> onLoading(chariDocs, userDocs, category) async {
    startLoading();
    refreshController.loadComplete();
    if (chariDocs.isNotEmpty) {
      final qshot = await returnQuery(category: category)
          .startAfterDocument(chariDocs.last)
          .limit(10)
          .get();
      final oldChariDocs = qshot.docs;
      final oldChariUids = oldChariDocs
          .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
          .toList();
      List oldUserDocs = [];
      for (String uid in oldChariUids) {
        final qshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        oldUserDocs.add(qshot);
      }

      for (final chariDoc in oldChariDocs) {
        chariDocs.add(chariDoc);
      }
      for (final chariDoc in oldUserDocs) {
        userDocs.add(chariDoc);
      }
    }
    endLoading();
  }
}
