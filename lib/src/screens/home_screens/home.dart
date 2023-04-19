import 'package:flutter/material.dart';

import '../add_edit_chari.dart';
import 'category_chari.dart';

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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditChariPage()));
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'all'),
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
            CategoryChari(category: 'all'),
            CategoryChari(category: 'single'),
            CategoryChari(category: 'MTB'),
            CategoryChari(category: 'touring'),
            CategoryChari(category: 'road'),
            CategoryChari(category: 'mini'),
            CategoryChari(category: 'mamachari'),
            CategoryChari(category: 'others'),
          ],
        ),
      ),
    );
  }
}
