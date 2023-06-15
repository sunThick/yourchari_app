import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import '../domain/chari/chari.dart';


final chariListFromCategoryProvider =
    FutureProvider.family<Tuple2<dynamic, dynamic>, String>(
        ((ref, category) async {
  if (category == 'all') {
    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .orderBy('createdAt', descending: true)
        .limit(10)
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
        .limit(10)
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
}));

