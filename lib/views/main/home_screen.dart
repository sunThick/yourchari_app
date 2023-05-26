// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/home_tab_model.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../constants/routes.dart';
import '../../domain/chari/chari.dart';
import '../../models/main/home_model.dart';
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
    final HomeModel homeModel = ref.watch(homeProvider);
    final HomeTabModel homeTabModel = ref.watch(homeTabProvider);
    final chariDocs = homeModel.chariDocs;
    final userDocs = homeModel.userDocs;
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
                print(index);
                homeTabModel.changePage(index);
              },
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
          body: CharisList(index: homeTabModel.currentIndex,),
          // body: TabBarView(
          //   children: [
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          //     Center(child: Text(homeTabModel.currentIndex.toString())),
          // CategoryChari(category: 'all'),
          // CategoryChari(category: 'single'),
          // CategoryChari(category: 'MTB'),
          // CategoryChari(category: 'touring'),
          // CategoryChari(category: 'road'),
          // CategoryChari(category: 'mini'),
          // CategoryChari(category: 'mamachari'),
          // CategoryChari(category: 'others'),
          // ],
          // ),
          // body: Center(child: Text(homeTabModel.currentIndex.toString())),
          // body: MasonryGridView.count(
          //     crossAxisCount: 2,
          //     itemCount: homeModel.chariDocs.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       final chariDoc = chariDocs[index];
          //       final userDoc = userDocs[index];
          //       final Chari chari = Chari.fromJson(chariDoc.data()!);
          //       final FirestoreUser passiveUser =
          //           FirestoreUser.fromJson(userDoc.data()!);
          //       return InkWell(
          //         onTap: () {
          //           toChariDetailPage(context: context, chariUid: chari.postId);
          //         },
          //         child: Card(
          //           clipBehavior: Clip.antiAlias,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Column(
          //             children: [
          //               Text(homeTabModel.currentIndex.toString()),
          //               ListTile(
          //                 leading: passiveUser.userImageURL.isEmpty
          //                     ? const CircleAvatar(child: Icon(Icons.person))
          //                     : CircleAvatar(
          //                         backgroundImage:
          //                             NetworkImage(passiveUser.userImageURL)),
          //                 title: Text(chari.brand),
          //                 subtitle: Text(
          //                   chari.frame,
          //                   style:
          //                       TextStyle(color: Colors.black.withOpacity(0.6)),
          //                 ),
          //               ),
          //               chari.imageURL.isEmpty
          //                   ? Container(
          //                       color: Colors.amber,
          //                       height: 50,
          //                     )
          //                   : Image.network(
          //                       (chari.imageURL[0]),
          //                       height: 150,
          //                       fit: BoxFit.fill,
          //                     ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }),
        ));
  }
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final HomeModel homeModel = ref.watch(homeProvider);
  //   print(homeModel);
  //   final chariDocs = homeModel.chariDocs;
  //   final userDocs = homeModel.userDocs;
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Image.asset(
  //         'assets/images/homeLogo.png',
  //         height: 40,
  //       ),
  //       backgroundColor: Colors.white,
  //     ),
  //     body: MasonryGridView.count(
  //         crossAxisCount: 2,
  //         // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         //   crossAxisCount: 2,
  //         //   mainAxisExtent: 250,
  //         // ),
  //         itemCount: homeModel.chariDocs.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           final chariDoc = chariDocs[index];
  //           final userDoc = userDocs[index];
  //           final Chari chari = Chari.fromJson(chariDoc.data()!);
  //           final FirestoreUser passiveUser =
  //               FirestoreUser.fromJson(userDoc.data()!);
  //           return InkWell(
  //             onTap: () {
  //               toChariDetailPage(context: context, chariUid: chari.postId);
  //             },
  //             child: Card(
  //               clipBehavior: Clip.antiAlias,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Column(
  //                 children: [
  //                   ListTile(
  //                     leading: passiveUser.userImageURL.isEmpty
  //                         ? const CircleAvatar(child: Icon(Icons.person))
  //                         : CircleAvatar(
  //                             backgroundImage:
  //                                 NetworkImage(passiveUser.userImageURL)),
  //                     title: Text(chari.brand),
  //                     subtitle: Text(
  //                       chari.frame,
  //                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
  //                     ),
  //                   ),
  //                   chari.imageURL.isEmpty
  //                       ? CircleAvatar(
  //                           backgroundImage:
  //                               NetworkImage(passiveUser.userImageURL))
  //                       : Image.network(
  //                           (chari.imageURL[0]),
  //                           height: 150,
  //                           fit: BoxFit.fill,
  //                         ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }
}
