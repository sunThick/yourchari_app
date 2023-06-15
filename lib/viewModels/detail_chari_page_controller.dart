import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chariDetailNotifierProvider =
    ChangeNotifierProvider.autoDispose(((ref) => ChariDetailPageController()));

class ChariDetailPageController extends ChangeNotifier {
  int currentIndex = 0;

  void changeImage(index) {
    currentIndex = index;
    notifyListeners();
  }

  ChariDetailPageController() {
    print('object');
  }
}
