// flutter

import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart' as routes;
// domain

final signupNotifierProvider =
    ChangeNotifierProvider((ref) => SignupController());

class SignupController extends ChangeNotifier {
  User? currentUser;

  // auth
  String name = "";
  String userImageURL = "";
  bool isObscure = true;

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  // Future<void> creaeFirestoreUser(
  //     {required BuildContext context, required String uid}) async {
  //   final Timestamp now = Timestamp.now();
  //   final FirestoreUser firestoreUser = FirestoreUser(
  //     createdAt: now,
  //     email: email,
  //     uid: uid,
  //     updatedAt: now,
  //     userImageURL: userImageURL,
  //     userName: userName,
  //     followerCount: 0,
  //     followingCount: 0,
  //   );
  //   final Map<String, dynamic> userData = firestoreUser.toJson();
  //   await FirebaseFirestore.instance.collection("users").doc(uid).set(userData);
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('ユーザーが作成できました')));
  //   notifyListeners();
  // }

  Future<void> createUser({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text);
      // ignore: use_build_context_synchronously
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
