// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  User? currentUser;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;

  MainModel() {
    init();
  }

  get followingUids => null;

  Future<void> init() async {
    startLoading();
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    //上記のdocumentsnapshotでデータを参照、取得
    currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    //classの形にして呼び出せるようにする  firestoreUser.____
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    endLoading();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
