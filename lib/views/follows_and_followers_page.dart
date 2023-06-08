import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/constants/routes.dart';
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
    final state = ref.watch(followersOrFollowsFamily(t2));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);
    final MainModel mainModel = ref.watch(mainProvider);

    return Scaffold(
        body: state.when(data: (state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(followingOrFollowers),
        ),
        body: ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final user = state[index];
            final bool isFollowing = mainModel.followingUids.contains(user.uid);
            return ListTile(
              leading: user.userImageURL.isEmpty
                  ? const CircleAvatar(
                      child: Icon(Icons.person),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(user.userImageURL),
                    ),
              title: Text(user.userName),
              subtitle: Text('Id: tasochan'),
              trailing: isFollowing
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
        ),
      );
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
