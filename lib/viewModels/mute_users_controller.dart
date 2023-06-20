import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../constants/enums.dart';
import '../constants/othes.dart';
import '../constants/string.dart';
import '../domain/mute_user_token/mute_user_token.dart';
import '../domain/user_mute/user_mute.dart';

final userMuteProvider =
    ChangeNotifierProvider(((ref) => UserMuteController()));

class UserMuteController extends ChangeNotifier {
  Future<void> muteUser({
    required MainController mainController,
    required String passiveUid,
    // docsには、postDocs等が含まれる
  }) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainController.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final Timestamp now = Timestamp.now();
    final passiveUserDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUid)
        .get();
    final MuteUserToken muteUserToken = MuteUserToken(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        tokenId: tokenId,
        tokenType: muteUserTokenTypeString);
    mainController.muteUserTokens.add(muteUserToken);
    mainController.muteUids.add(passiveUid);
    notifyListeners();
    // 自分がmuteしたことの印
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteUserToken.toJson());
    // muteされたことの印
    final UserMute userMute = UserMute(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        passiveUserRef: passiveUserDoc.reference);
    await passiveUserDoc.reference
        .collection("userMutes")
        .doc(activeUid)
        .set(userMute.toJson());
  }

  Future<void> unMuteUser(
      {required MainController mainController,
      required String passiveUid,
      required DocumentSnapshot<Map<String, dynamic>> muteUserDoc,
      required muteUserDocs
      }) async {
    // muteUsersModel側の処理
    muteUserDocs.remove(muteUserDoc);
    mainController.muteUids.remove(passiveUid);
    final currentUserDoc = mainController.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteMuteUserToken = mainController.muteUserTokens
        .where((element) => element.passiveUid == passiveUid)
        .toList()
        .first;
    mainController.muteUserTokens.remove(deleteMuteUserToken);
    
    notifyListeners();
    // 自分がミュートしたことの印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMuteUserToken.tokenId)
        .delete();
    // ユーザーのミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteUserRef =
        FirebaseFirestore.instance.collection("users").doc(passiveUid);
    await muteUserRef.collection("userMutes").doc(activeUid).delete();
  }
}

//     void showDialog(
//         {required BuildContext context,
//         required MainController mainController,
//         required String passiveUid,
//         // docsには、postDocs, commentDocsが含まれる
//         required List<DocumentSnapshot<Map<String, dynamic>>> docs}) {
//       showCupertinoModalPopup(
//           context: context,
//           builder: (BuildContext context) => CupertinoAlertDialog(
//                 title: const Text('ユーザーをミュートする'),
//                 content: const Text('ユーザーをミュートしますが本当によろしいですか？'),
//                 actions: [
//                   CupertinoDialogAction(
//                     /// This parameter indicates this action is the default,
//                     /// and turns the action's text to bold text.
//                     isDefaultAction: true,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('No'),
//                   ),
//                   CupertinoDialogAction(
//                     /// This parameter indicates this action is the default,
//                     /// and turns the action's text to bold text.
//                     isDestructiveAction: true,
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       await muteUser(
//                         mainController: mainController,
//                         passiveUid: passiveUid,
//                       );
//                     },
//                     child: const Text('Yes'),
//                   ),
//                 ],
//               ));
//     }

//     void showPopup(
//         {required BuildContext context,
//         required MainController mainController,
//         required String passiveUid,
//         // docsには、postDocs, commentDocsが含まれる
//         required List<DocumentSnapshot<Map<String, dynamic>>> docs}) {
//       showCupertinoModalPopup(
//           context: context,
//           builder: (BuildContext innerContext) => CupertinoActionSheet(
//                   title: const Text('操作を選択'),
//                   message: const Text('Message'),
//                   actions: [
//                     CupertinoActionSheetAction(
//                       isDestructiveAction: true,
//                       onPressed: () {
//                         Navigator.pop(innerContext);
//                         showDialog(
//                             context: context,
//                             mainController: mainController,
//                             passiveUid: passiveUid,
//                             docs: docs);
//                       },
//                       child: const Text("ユーザーをミュートする"),
//                     ),
//                     CupertinoActionSheetAction(
//                       /// This parameter indicates the action would perform
//                       /// a destructive action such as delete or exit and turns
//                       /// the action's text color to red.
//                       onPressed: () {
//                         Navigator.pop(innerContext);
//                       },
//                       child: const Text("戻る"),
//                     ),
//                   ]));
//     }
//   }
// }
