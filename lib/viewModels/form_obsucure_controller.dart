import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormObscureNotifier extends StateNotifier<bool> {
  FormObscureNotifier() : super(true);

  void toggle() {
    if (state == false) {
      state = true;
    } else {
      state = false;
    }
  }
}

final formObscureNotifier =
    StateNotifierProvider.autoDispose<FormObscureNotifier, bool>(
        (ref) => FormObscureNotifier());
