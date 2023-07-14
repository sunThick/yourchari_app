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
                Tab(child: Text('all', style: TextStyle(color: Colors.black))),
                Tab(child: Text('single', style: TextStyle(color: Colors.black))),
                Tab(child: Text('MTB', style: TextStyle(color: Colors.black))),
                Tab(child: Text('touring', style: TextStyle(color: Colors.black))),
                Tab(child: Text('road', style: TextStyle(color: Colors.black))),
                Tab(child: Text('mini', style: TextStyle(color: Colors.black))),
                Tab(child: Text('mamachari', style: TextStyle(color: Colors.black))),
                Tab(child: Text('others', style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
          body: CharisList(
            index: ref.watch(homeTabProvider),
          ),
        ));
  }
}
