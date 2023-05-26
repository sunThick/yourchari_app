import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../domain/chari/chari.dart';

final categoryFamily = FutureProvider.family<Tuple2<dynamic, dynamic>, String>(
    ((ref, category) async {
  if (category == 'all') {
    final chariQshot =
        await FirebaseFirestore.instance.collection('chari').get();
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

final allChariProvider = FutureProvider(((ref) => AllChariModel()));
final singleChariProvider = FutureProvider(((ref) => SingleChariModel()));
final mtbChariProvider = FutureProvider(((ref) => MiniChariModel()));
final touringChariProvider = FutureProvider(((ref) => TouringChariModel()));
final roadChariProvider = FutureProvider(((ref) => RoadAllChariModel()));
final miniChariProvider = FutureProvider(((ref) => MiniAllChariModel()));
final mamachariChariProvider =
    FutureProvider(((ref) => MamachariAllChariModel()));
final othersChariProvider = FutureProvider(((ref) => OthersAllChariModel()));

class AllChariModel extends ChangeNotifier {}

class MamachariAllChariModel extends ChangeNotifier {}

class MiniAllChariModel extends ChangeNotifier {}

class RoadAllChariModel extends ChangeNotifier {}

class TouringChariModel extends ChangeNotifier {}

class MiniChariModel extends ChangeNotifier {}

class SingleChariModel extends ChangeNotifier {}

class OthersAllChariModel extends ChangeNotifier {}
