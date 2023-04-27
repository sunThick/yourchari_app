// flutter
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants

final homeBottomNavigationBarProvider =
    ChangeNotifierProvider((ref) => HomeBottomNavigationBarModel());

class HomeBottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;

  HomeBottomNavigationBarModel() {
    init();
  }
  void init() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onTabTapped({required int index}) {
    //_positions.isNotEmptyのエラーをif文で解消
    if (pageController.hasClients) {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate);
    }
  }

  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
