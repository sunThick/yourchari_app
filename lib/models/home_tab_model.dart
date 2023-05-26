import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTabProvider = ChangeNotifierProvider(((ref) => HomeTabModel()));

class HomeTabModel extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(index) {
    currentIndex = index;
    notifyListeners();
  }
}
