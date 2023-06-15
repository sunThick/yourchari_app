import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/models/passive_user_model.dart';
import 'package:yourchari_app/viewModels/profile_controller.dart';
import 'package:yourchari_app/views/components/components.dart';

import '../constants/routes.dart';
import '../domain/chari/chari.dart';
import '../viewModels/passive_user_page_controller.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final PassiveUserController passiveUserController =
        ref.watch(passiveUserNotifierProvider);
    final ProfileController profileController =
        ref.watch(profileNotifierProvider);
        
    final String chariOrLikes =
        passiveUserController.currentIndex == 0 ? "chari" : "likes";
    const double headerHeight = 90;

    final state = ref.watch(passiveUserProvider(userId));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: state.when(data: (passiveUserDoc) {
        final FirestoreUser passiveUser =
            FirestoreUser.fromJson(passiveUserDoc.data()!);
        final bool isFollowing =
            mainController.followingUids.contains(passiveUser.uid);
        final int followerCount = passiveUser.followerCount;
        final int plusOneFollowerCount = passiveUser.followerCount + 1;
        final int minusOneFollowerCount = passiveUser.followerCount - 1;
        return Column(
          children: [
            SizedBox(
              height: headerHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: buildAvatarImage(
                            passiveUser: passiveUser,
                            currentFirestoreUser:
                                mainController.currentFirestoreUser,
                            profileController: profileController,
                            radius: headerHeight / 2)),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          passiveUser.userName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const Text('ID: taso_club7'),
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  '徒然なるままに自転車で旅をしています。',
                                  style: TextStyle(fontSize: 12),
                                )))
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
                        // buildButton(text: 'chari', value: chariDocs.length),
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
                              text: 'follwers',
                              value: passiveUserController.plusOne
                                  ? plusOneFollowerCount
                                  : passiveUserController.minusOne
                                      ? minusOneFollowerCount
                                      : followerCount),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: isFollowing
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.black, //枠線!
                                  width: 1, //枠線！
                                ),
                              ),
                              onPressed: () => passiveUserController.unfollow(
                                  mainController: mainController,
                                  passiveUser: passiveUser),
                              child: const Text('following'),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                //ボタンの背景色
                              ),
                              onPressed: () => passiveUserController.follow(
                                  mainController: mainController,
                                  passiveUser: passiveUser),
                              child: const Text('follow'),
                            ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.black),
            DefaultTabController(
                initialIndex: passiveUserController.currentIndex,
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black12,
                      tabs: const [Tab(text: "Chari"), Tab(text: "Likes")],
                      onTap: (index) {
                        passiveUserController.changePage(index);
                      },
                    ),
                  ],
                )),
            Consumer(builder: (context, ref, _) {
              final t2 = Tuple2<String, String>(userId, chariOrLikes);
              final chariDocs = ref.watch(passiveUserChariDocsProvider(t2));
              return chariDocs.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
                data: (chariDocs) {
                  return buildChariList(
                      context: context,
                      passiveUserModel: passiveUserController,
                      chariDocs: chariDocs);
                },
              );
            })
          ],
        );
      }, error: (Object error, StackTrace stackTrace) {
        return null;
      }, loading: () {
        return const Scaffold();
      }),
    );
  }

  Widget buildChariList(
      {required context,
      required PassiveUserController passiveUserModel,
      required chariDocs}) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          itemCount: chariDocs.length,
          itemBuilder: (BuildContext context, int index) {
            final doc = chariDocs[index];
            final Chari chari = Chari.fromJson(doc.data());
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
        ),
      ),
    );
  }
}