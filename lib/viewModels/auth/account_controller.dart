import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/othes.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';

import '../../constants/enums.dart';
import '../../constants/routes.dart' as routes;
import '../../constants/void.dart';

final accountProvider = ChangeNotifierProvider(((ref) => AccountController()));

class AccountController extends ChangeNotifier {
  User? currentUser = returnAuthUser();
  String password = "";
  ReauthenticationState reauthenticationState =
      ReauthenticationState.initialValue;

  Future<void> reauthenticateWithCredential(
      {required BuildContext context,
      required BuildContext homeContext}) async {
    // まず再認証をする
    currentUser = returnAuthUser();
    final String email = currentUser!.email!;
    // 認証情報
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await currentUser!.reauthenticateWithCredential(credential);
      switch (reauthenticationState) {
        case ReauthenticationState.initialValue:
          break;
        case ReauthenticationState.updatePassword:
          routes.toUpdatePasswordPage(context: context);
          break;
        case ReauthenticationState.updateEmail:
          routes.toUpdateEmailPage(context: context);
          break;
        case ReauthenticationState.deleteUser:
          routes.toDeleteUserPage(context: context, homeContext: homeContext);
          break;
      }
    } on FirebaseAuthException catch (e) {
      String msg = e.code;
      switch (e.code) {
        case "wrong-password":
          msg = 'パスワードが違います';
          break;
        case "invalid-email":
          msg = 'メールアドレスが正しくありません';
          break;
        case "invalid-credential":
          msg = 'クレデンシャルが無効です';
          break;
        case "user-not-found":
          msg = 'ユーザーが見つかりません';
          break;
        case "user-mismatch":
          msg = 'ユーザーが違います';
          break;
      }
      showToast(msg: msg);
    }
  }

  Future<void> deleteUser(
      {required BuildContext context,
      required FirestoreUser firestoreUser}) async {
    routes.toFinishedage(context: context, msg: 'アカウントを削除しました');

    // ユーザーの削除にはReauthenticationが必要
    // ユーザーの削除はFirebaseAuthのトークンがないといけない
    // Documentの方を削除 -> FirebaseAuthのユーザーを削除
    final User currentUser = returnAuthUser()!;
    // deleteUserを作成する
    try {
      await FirebaseFirestore.instance
          .collection("deleteUsers")
          .doc(currentUser.uid)
          .set(firestoreUser.toJson())
          .then((_) => currentUser.delete());
    } on FirebaseException catch (e) {
      showToast(msg: e.code);
    }
  }
}
