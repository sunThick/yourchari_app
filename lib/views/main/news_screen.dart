// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/login_model.dart';

class NewsScreen extends ConsumerWidget {
  NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    return Center(
      child: ElevatedButton(
        onPressed: () => loginModel.logout(),
        child: const Text('tomato'),
      ),
    );
  }
}
