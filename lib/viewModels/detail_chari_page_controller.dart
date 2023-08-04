import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';
import 'package:yourchari_app/constants/string.dart';
import 'package:yourchari_app/constants/void.dart';
import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/domain/post_report/post_report.dart';
import 'package:yourchari_app/views/components/report_contents_list_view.dart';

final chariDetailNotifierProvider =
    ChangeNotifierProvider.autoDispose(((ref) => DetailChariPageController()));

class DetailChariPageController extends ChangeNotifier {
  int currentIndex = 0;

  void changeImage(index) {
    currentIndex = index;
    notifyListeners();
  }

  void reportPost({required BuildContext context,required Chari chari,required FirestoreUser passiveuser,required DocumentSnapshot<Map<String,dynamic>> postDoc}) {
    // 選ばれたものを表示
    // valueNotifierは変更をすぐに検知
    final selectedReportContentsNotifier = ValueNotifier<List<String>>([]);
    final String postReportId = returnUuidV4();
    showFlashDialog(
      context: context, 
      content: ReportContentsListView(selectedReportContentsNotifier: selectedReportContentsNotifier,),
      positiveActionBuilder: (_,controller,__) {
        final postDocRef = postDoc.reference;
        return TextButton(
          onPressed: () async {
            final PostReport postReport = PostReport(
              acitiveUid: returnAuthUser()!.uid,
              createdAt: Timestamp.now(),
              reportContent: returnReportContentString(selectedReportContents: selectedReportContentsNotifier.value),
              postCreatorUid: chari.uid,
              passiveUserName: passiveuser.userName,
              postDocRef: postDocRef,
              postId: chari.postId,
              postReportId: postReportId,
            );
            await controller.dismiss();
            await showToast(msg: "投稿を報告しました");
            await postDocRef.collection("postReports").doc(postReportId).set(postReport.toJson());
          },
          child: const Text("送信",style: TextStyle(color: Colors.red), )
        );
      }
    );
  }
}
