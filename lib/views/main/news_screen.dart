// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/login_controller.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginController loginController = ref.watch(loginNotifierProvider);
    return Center(
      child: ElevatedButton(
        onPressed: () => loginController.logout(),
        child: const Text('tomato'),
      ),
    );
  }
}
