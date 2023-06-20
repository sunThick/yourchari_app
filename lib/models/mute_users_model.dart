import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

final muteUsersProvider = FutureProvider.autoDispose
    .family<List<DocumentSnapshot<Map<String, dynamic>>>, String>(
        ((ref, uid) async {
  final MainController mainController = ref.watch(mainProvider);
  final muteUserIds = mainController.muteUids;
  final List<DocumentSnapshot<Map<String, dynamic>>> muteUserDocs = [];
  for (final muteUserId in muteUserIds) {
    final muteUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(muteUserId)
        .get();
    muteUserDocs.add(muteUserDoc);
  }

  return muteUserDocs;
}));
