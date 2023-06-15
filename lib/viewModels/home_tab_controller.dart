import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTabProvider = ChangeNotifierProvider(((ref) => HomeTabController()));

class HomeTabController extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(index) {
    currentIndex = index;
    notifyListeners();
  }
}
