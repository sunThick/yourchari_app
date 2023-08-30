import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yourchari_app/models/category_models.dart';
import 'package:yourchari_app/viewModels/chari_like_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';
import 'package:yourchari_app/views/components/components.dart';

import '../constants/routes.dart';
import '../constants/string.dart';
import '../domain/chari/chari.dart';
import '../domain/firestore_user/firestore_user.dart';
import '../viewModels/home_chari_list_controller.dart';

class CharisList extends ConsumerWidget {
  const CharisList({Key? key, required this.index}) : super(key: key);
  // @override
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeChariListController categoryChariController =
        ref.watch(homeChariListProvider);
    final MainController mainController = ref.watch(mainProvider);
    final ProfileController profileController =
        ref.watch(profileNotifierProvider);
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
    final asyncValue = ref.watch(chariListFromCategoryProvider(category!));
    return Scaffold(
        body: Center(
            child: asyncValue.when(
                error: (err, _) => Text(err.toString()), //エラー時
                loading: () => const CircularProgressIndicator(),
                data: (data) {
                  List<DocumentSnapshot<Map<String, dynamic>>> chariDocs =
                      data.item1;
                  List<DocumentSnapshot<Map<String, dynamic>>> userDocs =
                      data.item2;
                  return Scaffold(
                      body: chariDocs.isEmpty
                          ? SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: categoryChariController
                                .refreshController,
                            header: const WaterDropHeader(),
                            onRefresh: () {
                              categoryChariController.startLoading();
                              // ignore: unused_result
                              ref.refresh(chariListFromCategoryProvider(
                                  category));
                              categoryChariController.refreshController
                                  .refreshCompleted();
                              categoryChariController.endLoading();
                            },
                            child: const Center(
                                child:
                                    Text('投稿がありません。下に引っ張って更新してください。')),
                          )
                          : SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: const WaterDropHeader(),
                            onRefresh: () {
                              categoryChariController.startLoading();
                              // ignore: unused_result
                              ref.refresh(chariListFromCategoryProvider(
                                  category));
                              categoryChariController.refreshController
                                  .refreshCompleted();
                              categoryChariController.endLoading();
                            },
                            onLoading: () async => {
                              await categoryChariController.onLoading(
                                  category: category,
                                  chariDocs: chariDocs,
                                  userDocs: userDocs,
                                  ref: ref)
                            },
                            controller: categoryChariController
                                .refreshController,
                            child: MasonryGridView.count(
                                crossAxisCount: 2,
                                itemCount: chariDocs.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  final chariDoc = chariDocs[index];
                                  final userDoc = userDocs[index];
                                  final Chari chari =
                                      Chari.fromJson(chariDoc.data()!);
                                  final FirestoreUser passiveUser =
                                      FirestoreUser.fromJson(
                                          userDoc.data()!);
                                  return InkWell(
                                      onTap: () {
                                        toChariDetailPage(
                                            context: context,
                                            chariUid: chari.postId);
                                      },
                                      onDoubleTap: () {},
                                      child: homeCard(
                                          chari: chari,
                                          passiveUser: passiveUser,
                                          mainController:
                                              mainController,
                                          profileController:
                                              profileController));
                                }),
                          ));
                })));
  }

  Widget homeCard(
      {required Chari chari,
      required FirestoreUser passiveUser,
      required MainController mainController,
      required ProfileController profileController}) {
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
                      currentFirestoreUser: mainController.currentFirestoreUser,
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
                      Consumer(builder: (context, ref, _) {
                        // ignore: unused_local_variable
                        final ChariLikeController charisModel =
                            ref.watch(chariLikeProvider);
                        final MainController mainController =
                            ref.watch(mainProvider);
                        return mainController.likeChariIds
                                .contains(chari.postId)
                            ? const Icon(
                                CupertinoIcons.heart_fill,
                                size: 15,
                                color: Colors.red,
                              )
                            : const Icon(
                                CupertinoIcons.heart,
                                size: 15,
                              );
                      }),
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
