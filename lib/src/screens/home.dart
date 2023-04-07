import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/homeLogo.png',
          fit: BoxFit.contain,
          height: 35,
        ),
      ),
      body:
          const Center(child: Text('home画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
