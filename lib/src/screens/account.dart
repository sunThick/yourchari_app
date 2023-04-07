import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('account'),
      ),
      body: const Center(
          child: Text('account画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
