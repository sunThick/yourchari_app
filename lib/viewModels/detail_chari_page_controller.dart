import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chariDetailNotifierProvider =
    ChangeNotifierProvider.autoDispose(((ref) => DetailChariPageController()));

class DetailChariPageController extends ChangeNotifier {
  int currentIndex = 0;

  void changeImage(index) {
    currentIndex = index;
    notifyListeners();
  }

  // void tomaot(Chari chari) {
  //   chari = chari.copyWith(brand: 'tomato');
  //   notifyListeners();
  //   print(chari);
  // }
}
