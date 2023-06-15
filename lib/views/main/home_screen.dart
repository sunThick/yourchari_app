// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/home_tab_controller.dart';
import '../home_charis_list.dart';
// constants

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        initialIndex: ref.watch(homeTabProvider),
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/homeLogo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.white54), //Change background color from here
              isScrollable: true,
              onTap: (index) {
                ref.read(homeTabProvider.notifier).changePage(index);
              },
              tabs: const [
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
          body: CharisList(
            index: ref.watch(homeTabProvider),
          ),
        ));
  }
}
