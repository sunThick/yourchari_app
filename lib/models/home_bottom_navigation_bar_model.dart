// flutter
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants

final homeBottomNavigationBarProvider =
    ChangeNotifierProvider((ref) => HomeBottomNavigationBarModel());

class HomeBottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;

  void onTabTapped({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
}
