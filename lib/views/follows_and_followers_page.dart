import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/followers_and_follows_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../viewModels/followers_or_follows_controller.dart';
import '../viewModels/passive_user_page_controller.dart';

class FollowsAndFollowersPage extends ConsumerWidget {
  const FollowsAndFollowersPage(
      {Key? key, required this.userUid, required this.followingOrFollowers})
      : super(key: key);
  final String userUid;
  final String followingOrFollowers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t2 = Tuple2<String, String>(userUid, followingOrFollowers);
    final userDocs = ref.watch(followersOrFollowsProvider(t2));
    final PassiveUserController passiveUserController =
        ref.watch(passiveUserNotifierProvider);
    final MainController mainController = ref.watch(mainProvider);
    final FollowersAndFollowsController followersAndFollowsController =
        ref.watch(followersOrFollowsNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(followingOrFollowers),
        ),
        body: userDocs.when(data: (userDocs) {
          return SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              header: const WaterDropHeader(),
              onLoading: () async =>
                  await followersAndFollowsController.onLoading(
                      followingOrFollowers: followingOrFollowers,
                      userDocs: userDocs,
                      userUid: userUid),
              controller: followersAndFollowsController.refreshController,
              child: ListView.builder(
                itemCount: userDocs.length,
                itemBuilder: (context, index) {
                  final userDoc = userDocs[index];
                  final FirestoreUser user =
                      FirestoreUser.fromJson(userDoc.data()!);
                  final bool isFollowing =
                      mainController.followingUids.contains(user.uid);
                  return ListTile(
                    leading: user.userImageURL.isEmpty
                        ? const CircleAvatar(
                            child: Icon(Icons.person),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(user.userImageURL),
                          ),
                    title: Text(user.userName),
                    subtitle: const Text('Id: tasochan'),
                    trailing: user.uid ==
                            mainController.currentFirestoreUser.uid
                        ? const Text('')
                        : isFollowing
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
                                    passiveUser: user),
                                child: const Text('following'),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  //ボタンの背景色
                                ),
                                onPressed: () => passiveUserController.follow(
                                    mainController: mainController,
                                    passiveUser: user),
                                child: const Text('follow'),
                              ),
                    onTap: () =>
                        toPassiveUserPage(context: context, userId: user.uid),
                  );
                },
              ));
        }, error: (Object error, StackTrace stackTrace) {
          return null;
        }, loading: () {
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
          );
        }));
  }
}
