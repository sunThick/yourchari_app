import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yourchari_app/models/category_models.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/profile_model.dart';
import 'package:yourchari_app/views/components/avator_image.dart';

import '../constants/routes.dart';
import '../constants/string.dart';
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
    final MainModel mainModel = ref.watch(mainProvider);
    final ProfileModel profileModel = ref.watch(profileProvider);
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
                                        userDocs: userDocs,
                                        mainModel: mainModel,
                                        profileModel: profileModel),
                                  ),
                                ),
                              ],
                            ));
                })));
  }

  Widget gridView(
      {required dynamic chariDocs,
      required dynamic userDocs,
      required MainModel mainModel,
      required ProfileModel profileModel}) {
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
              onDoubleTap: () {
                charisModel.unlike(
                                              chari: chari,
                                              chariDoc: chariDoc,
                                              chariRef: chariDoc.reference,
                                              mainModel: mainModel),
              },
              child: homeCard(
                  chari: chari,
                  passiveUser: passiveUser,
                  mainModel: mainModel,
                  profileModel: profileModel));
        });
  }

  Widget homeCard(
      {required Chari chari,
      required FirestoreUser passiveUser,
      required MainModel mainModel,
      required ProfileModel profileModel}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: chari.imageURL.first,
              memCacheHeight: 300,
              // maxHeightDiskCache: 300,
              placeholder: (context, url) => Container(
                color: Colors.grey,
                height: 150,
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chari.brand,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          chari.frame,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                    buildAvatarImage(
                      passiveUser: passiveUser,
                      currentFirestoreUser: mainModel.currentFirestoreUser,
                      profileModel: profileModel,
                      radius: 15,
                    )
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding:
                  const EdgeInsets.only(top: 3, right: 10, bottom: 3, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      mainModel.likeChariIds.contains(chari.postId)
                          ? const Icon(
                              CupertinoIcons.heart_fill,
                              size: 15,
                              color: Colors.red,
                            )
                          : const Icon(
                              CupertinoIcons.heart,
                              size: 15,
                            ),
                      Text(
                        chari.likeCount.toString(),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black45),
                      ),
                    ],
                  ),
                  Text(createTimeAgoString(chari.createdAt.toDate()),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black45))
                ],
              ),
            )
          ],
        ));
  }
}
