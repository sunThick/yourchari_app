import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';

import '../constants/routes.dart';
import '../domain/chari/chari.dart';

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
                body: Column(children: [
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
                          child: const Text('unfollow'),
                        )
                      : ElevatedButton(
                          onPressed: () => passiveUserModel.follow(
                              mainModel: mainModel, passiveUser: passiveUser),
                          child: const Text('follow'),
                        ),
                  const Divider(),
                  MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: chariDocs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final chariDoc = chariDocs[index];
                        final Chari chari = Chari.fromJson(chariDoc.data());
                        return InkWell(
                            onTap: () async => toChariDetailPage(
                                context: context, chariUid: chari.postId),
                            child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    chari.imageURL.isEmpty
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                passiveUser.userImageURL))
                                        : Image.network(
                                            (chari.imageURL.first),
                                            fit: BoxFit.fill,
                                          ),
                                    ListTile(
                                      trailing: passiveUser.userImageURL.isEmpty
                                          ? const CircleAvatar(
                                              child: Icon(Icons.person))
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  passiveUser.userImageURL)),
                                      title: Text(chari.brand),
                                      subtitle: Text(
                                        chari.frame,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                  ],
                                )));
                      })
                ]));
          },
          error: (Object error, StackTrace stackTrace) {
            return null;
          },
          loading: () {
            return Scaffold(
              appBar: AppBar(),
            );
          }),
    );
  }
}
