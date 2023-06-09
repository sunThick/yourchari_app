import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/constants/routes.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/followers_and_follows_model.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';

class FollowsAndFollowersPage extends ConsumerWidget {
  const FollowsAndFollowersPage(
      {Key? key, required this.userUid, required this.followingOrFollowers})
      : super(key: key);
  final String userUid;
  final String followingOrFollowers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t2 = Tuple2<String, String>(userUid, followingOrFollowers);
    final userDocs = ref.watch(followersOrFollowsFamily(t2));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);
    final MainModel mainModel = ref.watch(mainProvider);
    final FollowersAndFollowsModel followersAndFollowsModel =
        ref.watch(followersAndFollowsProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(followingOrFollowers),
        ),
        body: userDocs.when(data: (userDocs) {
          return SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              header: const WaterDropHeader(),
              onLoading: () async => await followersAndFollowsModel.onLoading(
                  followingOrFollowers: followingOrFollowers,
                  userDocs: userDocs,
                  userUid: userUid),
              controller: followersAndFollowsModel.refreshController,
              child: ListView.builder(
                itemCount: userDocs.length,
                itemBuilder: (context, index) {
                  final userDoc = userDocs[index];
                  final FirestoreUser user =
                      FirestoreUser.fromJson(userDoc.data()!);
                  final bool isFollowing =
                      mainModel.followingUids.contains(user.uid);
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
                    trailing: user.uid == mainModel.firestoreUser.uid
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
                                onPressed: () => passiveUserModel.unfollow(
                                    mainModel: mainModel, passiveUser: user),
                                child: const Text('following'),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  //ボタンの背景色
                                ),
                                onPressed: () => passiveUserModel.follow(
                                    mainModel: mainModel, passiveUser: user),
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
