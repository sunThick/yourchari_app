import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firstUserProvider = FutureProvider.autoDispose
    .family<DocumentSnapshot<Map<String, dynamic>>, String>(((ref, uid) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return userDoc;
}));