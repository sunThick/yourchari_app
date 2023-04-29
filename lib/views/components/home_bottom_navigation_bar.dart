// flutter
import 'package:flutter/material.dart';

import '../../constants/bottom_navigation_bar_elements.dart';
import '../../models/home_bottom_navigation_bar_model.dart';
// constants

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar(
      {Key? key, required this.homeBottomNavigationBarModel})
      : super(key: key);

  final HomeBottomNavigationBarModel homeBottomNavigationBarModel;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarElements,
        currentIndex: homeBottomNavigationBarModel.currentIndex,
        onTap: (index) =>
            homeBottomNavigationBarModel.onTabTapped(index: index),
        elevation: 0.0);
  }
}
