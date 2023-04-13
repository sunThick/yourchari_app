import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/homeLogo.png',
            fit: BoxFit.contain,
            height: 35,
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'al'),
              Tab(text: 'single'),
              Tab(text: 'MTB'),
              Tab(text: 'touring'),
              Tab(text: 'road'),
              Tab(text: 'mini'),
              Tab(text: 'mamachari'),
              Tab(text: 'others'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('all', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('single', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('MTB', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('touring', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('road', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('mini', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('mamachari', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('others', style: TextStyle(fontSize: 32.0)),
            ),
          ],
        ),
      ),
    );
  }
}
