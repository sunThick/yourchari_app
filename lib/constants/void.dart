import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../domain/chari/chari.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> chariWithoutMuteUser(
    {required List<QueryDocumentSnapshot<Map<String, dynamic>>> chariDocs,
    required MainController mainController}) {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>
      chariWithoutMuteUserDocs = [];
  final List<String> muteUids = mainController.muteUids;
  for (final chariDoc in chariDocs) {
    final Chari chari = Chari.fromJson(chariDoc.data());
    if (!muteUids.contains(chari.uid)) {
      chariWithoutMuteUserDocs.add(chariDoc);
    }
  }
  return chariWithoutMuteUserDocs;
}
