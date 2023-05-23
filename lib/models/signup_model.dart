// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart' as routes;
import '../domain/firestore_user/firestore_user.dart';
// domain

final signupProvider = ChangeNotifierProvider((ref) => SignupModel());

class SignupModel extends ChangeNotifier {
  User? currentUser;
  // auth
  String userName = "";
  String email = "";
  String password = "";
  String userImageURL = "";
  bool isObscure = true;

  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      email: email,
      uid: uid,
      updatedAt: now,
      userImageURL: userImageURL,
      userName: userName,
      followerCount: 0,
      followingCount: 0,
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();
    await FirebaseFirestore.instance.collection("users").doc(uid).set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
