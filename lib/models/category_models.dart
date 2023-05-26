import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../domain/firestore_user/firestore_user.dart';

final categoryFamily = FutureProvider.family<
    List<QueryDocumentSnapshot<Map<String, dynamic>>>,
    int>(((ref, index) async {
  final chariQshot = await FirebaseFirestore.instance
      .collection('chari')
      .where('category', isEqualTo: int)
      .get();
  return chariQshot.docs;
}));

final categoryF = FutureProvider.family<String, String>(((ref, category) async {
  await Future.delayed(const Duration(seconds: 5));
  return category;
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
