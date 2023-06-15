import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chari/chari.dart';

class SelectedChariNotifier extends StateNotifier<Chari> {
  SelectedChariNotifier()
      : super(const Chari(
            brand: "",
            caption: '',
            category: '',
            createdAt: null,
            frame: '',
            imageURL: [],
            likeCount: 0,
            postId: '',
            uid: '',
            updatedAt: null));
  // homeListのchariからdetailChariに行った時、新しく取得したchariをhomeListのviewに反映
  void changeChari(Chari chari) {
    state = chari;
  }
}

final selectedChariProvider =
    StateNotifierProvider<SelectedChariNotifier, Chari>(
        (ref) => SelectedChariNotifier());
