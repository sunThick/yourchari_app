import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/constants/string.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/domain/inquiry/inquiry.dart';

import '../constants/othes.dart';

final inquiryProvider =
    ChangeNotifierProvider.autoDispose(((ref) => InquiryPageController()));

class InquiryPageController extends ChangeNotifier {
  TextEditingController inquiryEditingController = TextEditingController();

  bool contentRequired = false;

  createInquiry(
      {required FirestoreUser firestoreUser, required context}) async {
    final uid = firestoreUser.uid;
    final inuqiryId = returnUuidV4();
    final content = inquiryEditingController.text.trim();
    if (content == "") {
      contentRequired = true;
      notifyListeners();
      return;
    }

    final Inquiry inquiryContent = Inquiry(
        createdAt: Timestamp.now(),
        userName: firestoreUser.userName,
        uid: uid,
        content: content,
        inquiryId: inuqiryId);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('inquiries')
        .doc(inuqiryId)
        .set(inquiryContent.toJson());
    toCompleteInquiryPage(context: context, content: content);
  }
}
