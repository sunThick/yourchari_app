// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/home_tab_model.dart';
import '../home_charis_list.dart';
// constants

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final HomeTabModel homeTabModel = ref.watch(homeTabProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('タブ画面移動サンプル'),
//         bottom: const TabBar(
//           // controller: homeTabModel.tabController,
//           tabs: <Widget>[
//             Tab(icon: Icon(Icons.cloud_outlined)),
//             Tab(icon: Icon(Icons.beach_access_sharp)),
//             Tab(icon: Icon(Icons.brightness_5_sharp)),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: <Widget>[
//           Center(child: Text('くもり', style: TextStyle(fontSize: 50))),
//           Center(child: Text('雨', style: TextStyle(fontSize: 50))),
//           Center(child: Text('晴れ', style: TextStyle(fontSize: 50))),
//         ],
//       ),
//     );
//   }

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeTabModel homeTabModel = ref.watch(homeTabProvider);
    return DefaultTabController(
        initialIndex: homeTabModel.currentIndex,
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
                homeTabModel.changePage(index);
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
            index: homeTabModel.currentIndex,
          ),
        ));
  }
}
