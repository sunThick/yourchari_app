import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabNotifier extends StateNotifier<int> {
  HomeTabNotifier() : super(0);

  void changePage(index) {
    state = index;
  }
}

final homeTabProvider =
    StateNotifierProvider<HomeTabNotifier, int>((ref) => HomeTabNotifier());
