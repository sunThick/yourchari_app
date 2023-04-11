import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('news'),
      ),
      body:
          const Center(child: Text('news画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
