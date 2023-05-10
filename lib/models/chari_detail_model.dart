import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chariDetailProvider = ChangeNotifierProvider(((ref) => ChariDetailModel()));

class ChariDetailModel extends ChangeNotifier {

  Future<void> init({required }) async {
    startLoading();
    final qshot = await FirebaseFirestore.instance
        .collection('charis')
        .doc()
        .get();
    endLoading();
  }

  bool isLoading = false;
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}

