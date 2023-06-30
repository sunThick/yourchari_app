import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import '../constants/void.dart';
import '../domain/chari/chari.dart';

final chariListFromCategoryProvider = FutureProvider.family<
    Tuple2<List<DocumentSnapshot<Map<String, dynamic>>>,
        List<DocumentSnapshot<Map<String, dynamic>>>>,
    String>(((ref, category) async {
  final MainController mainController = ref.watch(mainProvider);
  if (category == 'all') {
    final chariQshot = await FirebaseFirestore.instance
        .collection('chari')
        .orderBy('createdAt', descending: true)
        .limit(15)
        .get();
    final preChariDocs = chariQshot.docs;
    final chariDocs = chariWithoutMuteUser(
        chariDocs: preChariDocs, mainController: mainController);
    final chariUids = chariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();

    final List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];
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
        .limit(15)
        .get();
    final preChariDocs = chariQshot.docs;
    final chariDocs = chariWithoutMuteUser(
        chariDocs: preChariDocs, mainController: mainController);
    final chariUids = chariDocs
        .map((dynamic value) => (Chari.fromJson(value.data()!).uid))
        .toList();
    final List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];
    for (String uid in chariUids) {
      final qshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDocs.add(qshot);
    }
    return Tuple2(chariDocs, userDocs);
  }
}));
