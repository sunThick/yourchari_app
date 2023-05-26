import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passiveUserFamily(userId));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);
    final MainModel mainModel = ref.watch(mainProvider);

    return Scaffold(
      body: state.when(
          data: (passiveUserAndCharis) {
            final passiveUser = passiveUserAndCharis.item1;
            final chariDocs = passiveUserAndCharis.item2;
            final bool isFollowing =
                mainModel.followingUids.contains(passiveUser.uid);
            return Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Text(passiveUser.uid)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "フォロー中${passiveUser.followingCount.toString()}",
                        style: const TextStyle(fontSize: 32.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "フォロー中${passiveUser.followerCount.toString()}",
                        style: const TextStyle(fontSize: 32.0),
                      ),
                    ),
                    isFollowing
                        ? ElevatedButton(
                            onPressed: () => passiveUserModel.unfollow(
                                mainModel: mainModel, passiveUser: passiveUser),
                            child: Text('unfollow'),
                          )
                        : ElevatedButton(
                            onPressed: () => passiveUserModel.follow(
                                mainModel: mainModel, passiveUser: passiveUser),
                            child: Text('follow'),
                          ),
                    ElevatedButton(
                        onPressed: () => {print(mainModel.followingUids)},
                        child: Text(''))
                  ],
                ));
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {
            return Scaffold(
              appBar: AppBar(),
            );
          }),
    );
  }
}
