import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yourchari_app/models/category_models.dart';

import '../constants/routes.dart';
import '../domain/chari/chari.dart';
import '../domain/firestore_user/firestore_user.dart';

class CharisList extends ConsumerWidget {
  const CharisList({Key? key, required this.index}) : super(key: key);
  // @override
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CategoryChariModel categoryChariModel =
        ref.watch(categoryChariProvider);
    // 渡されたカテゴリーのインデックスから対応したStringのcategoryを取得。
    final Map<int, String> categoryMap = {
      0: 'all',
      1: 'single',
      2: 'MTB',
      3: 'touring',
      4: 'road',
      5: 'mini',
      6: 'mamachari',
      7: 'others',
    };
    final category = categoryMap[index];
    final asyncValue = ref.watch(categoryFamily(category!));
    return Scaffold(
        body: Center(
            child: asyncValue.when(
                error: (err, _) => Text(err.toString()), //エラー時
                loading: () => const CircularProgressIndicator(),
                data: (data) {
                  dynamic chariDocs = data.item1;
                  dynamic userDocs = data.item2;
                  return Scaffold(
                      body: chariDocs.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: SmartRefresher(
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    controller:
                                        categoryChariModel.refreshController,
                                    header: const WaterDropHeader(),
                                    onRefresh: () async =>
                                        await categoryChariModel.onReload(
                                            category: category,
                                            chariDocs: chariDocs,
                                            userDocs: userDocs),
                                    child: const Center(
                                        child:
                                            Text('投稿がありません。下に引っ張って更新してください。')),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: SmartRefresher(
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    header: const WaterDropHeader(),
                                    onRefresh: () async =>
                                        await categoryChariModel.onRefresh(
                                            chariDocs, userDocs, category),
                                    onLoading: () async =>
                                        await categoryChariModel.onLoading(
                                            chariDocs, userDocs, category),
                                    controller:
                                        categoryChariModel.refreshController,
                                    child: gridView(
                                        chariDocs: chariDocs,
                                        userDocs: userDocs),
                                  ),
                                ),
                              ],
                            ));
                })));
  }

  Widget gridView({required dynamic chariDocs, required dynamic userDocs}) {
    return MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: chariDocs.length,
        itemBuilder: (BuildContext context, int index) {
          final chariDoc = chariDocs[index];
          final userDoc = userDocs[index];
          final Chari chari = Chari.fromJson(chariDoc.data()!);
          final FirestoreUser passiveUser =
              FirestoreUser.fromJson(userDoc.data()!);
          return InkWell(
              onTap: () {
                toChariDetailPage(context: context, chariUid: chari.postId);
              },
              child: homeCard(chari: chari, passiveUser: passiveUser));
        });
  }

  Widget homeCard({required Chari chari, required FirestoreUser passiveUser}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chari.imageURL.isEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(passiveUser.userImageURL))
                : Image.network(
                    (chari.imageURL[0]),
                    fit: BoxFit.fill,
                  ),
            ListTile(
              trailing: passiveUser.userImageURL.isEmpty
                  ? const CircleAvatar(child: Icon(Icons.person))
                  : CircleAvatar(
                      backgroundImage: NetworkImage(passiveUser.userImageURL)),
              title: Text(chari.brand),
              subtitle: Text(
                chari.frame,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ));
  }
  // Widget homeCard({required Chari chari, required FirestoreUser passiveUser}) {
  //   return Card(
  //       clipBehavior: Clip.antiAlias,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         children: [
  //           ListTile(
  //             leading: passiveUser.userImageURL.isEmpty
  //                 ? const CircleAvatar(child: Icon(Icons.person))
  //                 : CircleAvatar(
  //                     backgroundImage: NetworkImage(passiveUser.userImageURL)),
  //             title: Text(chari.brand),
  //             subtitle: Text(
  //               chari.frame,
  //               style: TextStyle(color: Colors.black.withOpacity(0.6)),
  //             ),
  //           ),
  //           chari.imageURL.isEmpty
  //               ? CircleAvatar(
  //                   backgroundImage: NetworkImage(passiveUser.userImageURL))
  //               : Image.network(
  //                   (chari.imageURL[0]),
  //                   height: 150,
  //                   fit: BoxFit.fill,
  //                 ),
  //         ],
  //       ));
  // }
}
