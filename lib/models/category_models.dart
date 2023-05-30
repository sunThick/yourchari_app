import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../domain/chari/chari.dart';

final categoryFamily = FutureProvider.family<Tuple2<dynamic, dynamic>, String>(
    ((ref, category) async {
  if (category == 'all') {
    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .orderBy('createdAt', descending: true)
        .get();
    final chariDocs = chariQshot.docs;
    final chariUids = chariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();

    final List<dynamic> userDocs = [];
    for (String uid in chariUids) {
      final qshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDocs.add(qshot);
    }
    return Tuple2(chariDocs, userDocs);
  } else {
    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .get();
    final chariDocs = chariQshot.docs;
    final chariUids = chariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();

    final List<dynamic> userDocs = [];
    for (String uid in chariUids) {
      final qshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDocs.add(qshot);
    }

    return Tuple2(chariDocs, userDocs);
  }

  // chariDocsに対応したuidを配列で取得
}));

final categoryChariProvider =
    ChangeNotifierProvider(((ref) => CategoryChariModel()));

class CategoryChariModel extends ChangeNotifier {
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

  Future<void> onReload({required String category, required chariDocs}) async {
    startLoading();
    final qshot = await returnQuery(category: category).get();
    chariDocs = qshot.docs;
    endLoading();
  }

  Future<void> onLoading(chariDocs, category) async {
    startLoading();
    refreshController.loadComplete();
    if (chariDocs.isNotEmpty) {
      final qshot = await returnQuery(category: category)
          .startAfterDocument(chariDocs.last)
          .get();
      for (final chariDoc in qshot.docs) {
        chariDocs.add(chariDoc);
      }
    }
    endLoading();
  }
}


// final allChariProvider = FutureProvider(((ref) => AllChariModel()));
// final singleChariProvider = FutureProvider(((ref) => SingleChariModel()));
// final mtbChariProvider = FutureProvider(((ref) => MiniChariModel()));
// final touringChariProvider = FutureProvider(((ref) => TouringChariModel()));
// final roadChariProvider = FutureProvider(((ref) => RoadAllChariModel()));
// final miniChariProvider = FutureProvider(((ref) => MiniAllChariModel()));
// final mamachariChariProvider =
//     FutureProvider(((ref) => MamachariAllChariModel()));
// final othersChariProvider = FutureProvider(((ref) => OthersAllChariModel()));

// class AllChariModel extends ChangeNotifier {}

// class MamachariAllChariModel extends ChangeNotifier {}

// class MiniAllChariModel extends ChangeNotifier {}

// class RoadAllChariModel extends ChangeNotifier {}

// class TouringChariModel extends ChangeNotifier {}

// class MiniChariModel extends ChangeNotifier {}

// class SingleChariModel extends ChangeNotifier {}

// class OthersAllChariModel extends ChangeNotifier {}
