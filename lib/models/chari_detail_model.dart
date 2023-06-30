import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:tuple/tuple.dart';

final chariDetailProvider =
// tupleを用いて自転車のpostIdからChariとFirestoreUserをreturn
    FutureProvider.autoDispose.family<
        Tuple2<DocumentSnapshot<Map<String, dynamic>>,
            DocumentSnapshot<Map<String, dynamic>>>,
        String>(((ref, uid) async {
  final chariDoc =
      await FirebaseFirestore.instance.collection('chari').doc(uid).get();

  // chariDocがnullの場合は、tuple2<null, null> をreturn
  if (chariDoc.data() == null) {
    final chariAndPassiveUser = Tuple2<DocumentSnapshot<Map<String, dynamic>>,
        DocumentSnapshot<Map<String, dynamic>>>(chariDoc, chariDoc);
    return chariAndPassiveUser;
  }

  final chari = Chari.fromJson(chariDoc.data()!);
  final userId = chari.uid;
  final passiveUserDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final chariAndPassiveUser = Tuple2<DocumentSnapshot<Map<String, dynamic>>,
      DocumentSnapshot<Map<String, dynamic>>>(chariDoc, passiveUserDoc);
  return chariAndPassiveUser;
}));
