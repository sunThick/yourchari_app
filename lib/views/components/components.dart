// ignore_for_file: unused_result

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../../constants/routes.dart';
import '../../constants/string.dart';
import '../../domain/chari/chari.dart';
import '../../models/passive_user_model.dart';
import '../../viewModels/chari_like_controller.dart';
import '../../viewModels/passive_user_page_controller.dart';

Widget buildAvatarImage(
    {required FirestoreUser passiveUser,
    required FirestoreUser currentFirestoreUser,
    required double radius}) {
  return passiveUser.uid == currentFirestoreUser.uid
      ? currentFirestoreUser.userImageURL.isEmpty
          ? CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              child: const Icon(
                Icons.person,
                color: Colors.white70,
              ))
          : CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(currentFirestoreUser.userImageURL),
            )
      : passiveUser.userImageURL.isEmpty
          ? CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              child: const Icon(
                Icons.person,
                color: Colors.white70,
              ),
            )
          : CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(passiveUser.userImageURL),
            );
}

Widget buildButton({
  required String text,
  required int value,
}) =>
    Column(children: [
      Text(
        '$value',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 2),
      Text(
        text,
        style: const TextStyle(fontSize: 15),
      )
    ]);

Widget profileAndPassiveBody(
    {required context, required String userId, required bool isProfile}) {
  return Consumer(builder: (context, ref, _) {
    final userDocs = ref.watch(passiveUserProvider(userId));
    final PassiveUserController passiveUserController =
        ref.watch(passiveUserNotifierProvider);
    final MainController mainController = ref.watch(mainProvider);
    final bool themOrPassiveUser =
        userId == mainController.currentFirestoreUser.uid;
    const double headerHeight = 90;
    return Scaffold(
      body: userDocs.when(data: (value) {
        final passiveUserDoc = value;
        if (passiveUserDoc.data() == null) {
          return const Center(
            child: Text('このユーザーは削除されているか、退会しています。'),
          );
        }
        FirestoreUser passiveUser =
            FirestoreUser.fromJson(passiveUserDoc.data()!);
        if (isProfile) {
          passiveUser = mainController.currentFirestoreUser;
        }
        if (mainController.muteUids.contains(passiveUser.uid)) {
          return const Center(
            child: Text('このユーザーは現在ミュートしています。'),
          );
        }
        final bool isFollowing =
            mainController.followingUids.contains(passiveUser.uid);
        final int followerCount = passiveUser.followerCount;
        // final int plusOneFollowerCount = passiveUser.followerCount + 1;
        // final int minusOneFollowerCount = passiveUser.followerCount - 1;
        return RefreshIndicator(
          onRefresh: () async {
            ref.refresh(passiveUserProvider(userId));
            ref.refresh(passiveUserChariDocsProvider(userId));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: headerHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: buildAvatarImage(
                                  passiveUser: passiveUser,
                                  currentFirestoreUser:
                                      mainController.currentFirestoreUser,
                                  radius: headerHeight / 2)),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                passiveUser.displayName == ""
                                    ? passiveUser.userName
                                    : passiveUser.displayName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(passiveUser.userName),
                              Container(
                                  alignment: Alignment.center,
                                  child: Flexible(
                                    child: Text(
                                      passiveUser.introduction,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // buildButton(text: 'chari', value: 3),
                              InkWell(
                                onTap: () => {
                                  toFollowsAndFollowersPage(
                                      context: context,
                                      followingOrFollowers: "following",
                                      userUid: passiveUser.uid)
                                },
                                child: buildButton(
                                    text: 'follwing',
                                    value: passiveUser.followingCount),
                              ),
                              InkWell(
                                onTap: () => {
                                  toFollowsAndFollowersPage(
                                      context: context,
                                      followingOrFollowers: "followers",
                                      userUid: passiveUser.uid)
                                },
                                child: buildButton(
                                    text: 'follwers', value: followerCount),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: themOrPassiveUser
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Colors.black, //枠線!
                                      width: 1, //枠線！
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'edit profile',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : Container(
                                  child: isFollowing
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(
                                              color: Colors.black, //枠線!
                                              width: 1, //枠線！
                                            ),
                                          ),
                                          onPressed: () =>
                                              passiveUserController.unfollow(
                                                  mainController:
                                                      mainController,
                                                  passiveUser: passiveUser),
                                          child: const Text(
                                            'following',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            //ボタンの背景色
                                          ),
                                          onPressed: () =>
                                              passiveUserController.follow(
                                                  mainController:
                                                      mainController,
                                                  passiveUser: passiveUser),
                                          child: const Text(
                                            'follow',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                ),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black),
                  passiveUserChariList(uid: userId)
                ],
              ),
            ),
          ),
        );
      }, error: (Object error, StackTrace stackTrace) {
        return null;
      }, loading: () {
        return const CircularProgressIndicator();
      }),
    );
  });
}

Widget passiveUserChariList({required String uid}) {
  return Consumer(builder: (context, ref, _) {
    final chariDocs = ref.watch(passiveUserChariDocsProvider(uid));
    return chariList(asyncChariDocs: chariDocs, context: context);
  });
}

Widget chariList(
    {required AsyncValue<List<DocumentSnapshot<Map<String, dynamic>>>>
        asyncChariDocs,
    required context}) {
  return asyncChariDocs.when(
      error: (err, _) => Text(err.toString()), //エラー時
      loading: () => const CircularProgressIndicator(),
      data: (data) {
        final chariDocs = data;
        if (chariDocs.isEmpty) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Text('no chari'),
              SizedBox(
                height: 150,
              ),
            ],
          );
        }
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: chariDocs.length,
          itemBuilder: (BuildContext context, int index) {
            final DocumentSnapshot<Map<String, dynamic>> chariDoc =
                chariDocs[index];
            if (chariDoc.data() == null) {
              return null;
            }
            final Chari chari = Chari.fromJson(chariDoc.data()!);
            return InkWell(
              onTap: () async =>
                  toChariDetailPage(context: context, chariUid: chari.postId),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(children: [
                  Image.network(
                    (chari.imageURL[0]),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chari.brand,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                              Text(
                                chari.frame,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ]),
              ),
            );
          },
        );
      });
}

Widget homeCard({
  required Chari chari,
  required FirestoreUser passiveUser,
  required MainController mainController,
}) {
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
                      return mainController.likeChariIds.contains(chari.postId)
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
                    style: const TextStyle(fontSize: 15, color: Colors.black45))
              ],
            ),
          )
        ],
      ));
}
