import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';
import 'package:yourchari_app/models/profile_model.dart';

import '../constants/routes.dart';
import '../domain/chari/chari.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;

// widgetのcomponent
  Widget buildButton({
    required String text,
    required int value,
  }) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              )
            ]),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passiveUserFamily(userId));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);
    final ProfileModel profileModel = ref.watch(profileProvider);
    final MainModel mainModel = ref.watch(mainProvider);
    const double coverHeight = 100;
    const double profileHeight = 100;
    const bottom = profileHeight / 2;
    const top = coverHeight - profileHeight / 2;

    return Scaffold(
      body: state.when(data: (passiveUserAndCharis) {
        final passiveUserDoc = passiveUserAndCharis.item1;
        final FirestoreUser passiveUser =
            FirestoreUser.fromJson(passiveUserDoc.data()!);
        final chariDocs = passiveUserAndCharis.item2;
        final bool isFollowing =
            mainModel.followingUids.contains(passiveUser.uid);
        final int followerCount = passiveUser.followerCount;
        final int plusOneFollowerCount = passiveUser.followerCount + 1;
        final int minusOneFollowerCount = passiveUser.followerCount - 1;
        return Scaffold(
            appBar: AppBar(
              title: Text(passiveUser.userName),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: bottom),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                          color: Colors.grey,
                          child: mainModel.firestoreUser.userImageURL.isNotEmpty
                              ? Image.network(
                                  mainModel.firestoreUser.userImageURL,
                                  width: double.infinity,
                                  height: coverHeight,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey,
                                  width: double.infinity,
                                  height: coverHeight,
                                )),
                      Positioned(
                        top: top,
                        child: Container(
                          // croppedfileがなければcloudstorageのファイルを表示
                          child: profileModel.croppedFile != null
                              ? CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundImage:
                                      Image.file(profileModel.croppedFile!)
                                          .image,
                                )
                              : Container(
                                  // croppedfileがなければcloudstorageのファイルを表示
                                  child: mainModel
                                          .firestoreUser.userImageURL.isEmpty
                                      ? const CircleAvatar(
                                          radius: profileHeight / 2,
                                          child: Icon(Icons.person))
                                      : CircleAvatar(
                                          radius: profileHeight / 2,
                                          backgroundImage: NetworkImage(
                                              mainModel
                                                  .firestoreUser.userImageURL)),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    mainModel.firestoreUser.userName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton(text: 'chari', value: chariDocs.length),
                    buildButton(
                        text: 'follwing', value: passiveUser.followingCount),
                    buildButton(
                        text: 'follwers',
                        value: passiveUserModel.plusOne
                            ? plusOneFollowerCount
                            : passiveUserModel.minusOne
                                ? minusOneFollowerCount
                                : followerCount)
                    // value: mainModel.followingUids.contains(passiveUser.uid)
                    //     ? passiveUserModel.followed
                    //         ? followerCount
                    //         : plusOneFollowerCount
                    //     : followerCount)
                  ],
                ),
                isFollowing
                    ? ElevatedButton(
                        onPressed: () => passiveUserModel.unfollow(
                            mainModel: mainModel, passiveUser: passiveUser),
                        child: const Text('フォロー中'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, //ボタンの背景色
                        ),
                        onPressed: () => passiveUserModel.follow(
                            mainModel: mainModel, passiveUser: passiveUser),
                        child: const Text('フォローする'),
                      ),
                const Divider(color: Colors.black),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      itemCount: chariDocs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final doc = chariDocs[index];
                        final Chari chari = Chari.fromJson(doc.data()!);
                        return InkWell(
                          onTap: () async => toChariDetailPage(
                              context: context, chariUid: chari.postId),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              (chari.imageURL[0]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ));

        // return Scaffold(
        //     appBar: AppBar(
        //       title: Text(passiveUser.userName),
        //       elevation: 0,
        //       backgroundColor: Colors.transparent,
        //       actions: <Widget>[
        //         IconButton(
        //           onPressed: () {},
        //           icon: const Icon(Icons.more_vert),
        //         ),
        //       ],
        //     ),
        //     body: Column(children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 16.0),
        //         child: Text(
        //           "フォロー中${passiveUser.followingCount.toString()}",
        //           style: const TextStyle(fontSize: 32.0),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 16.0),
        //         child: Text(
        //           "フォロー中${passiveUser.followerCount.toString()}",
        //           style: const TextStyle(fontSize: 32.0),
        //         ),
        //       ),
        //       isFollowing
        //           ? ElevatedButton(
        //               onPressed: () => passiveUserModel.unfollow(
        //                   mainModel: mainModel, passiveUser: passiveUser),
        //               child: const Text('unfollow'),
        //             )
        //           : ElevatedButton(
        //               onPressed: () => passiveUserModel.follow(
        //                   mainModel: mainModel, passiveUser: passiveUser),
        //               child: const Text('follow'),
        //             ),
        //       const Divider(),
        //       SizedBox(
        //         height: MediaQuery.of(context).size.height,
        //         child: MasonryGridView.count(
        //             crossAxisCount: 2,
        //             itemCount: chariDocs.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               final chariDoc = chariDocs[index];
        //               final Chari chari = Chari.fromJson(chariDoc.data());
        //               return InkWell(
        //                   onTap: () async => toChariDetailPage(
        //                       context: context, chariUid: chari.postId),
        //                   child: Card(
        //                       clipBehavior: Clip.antiAlias,
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(10),
        //                       ),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           chari.imageURL.isEmpty
        //                               ? CircleAvatar(
        //                                   backgroundImage: NetworkImage(
        //                                       passiveUser.userImageURL))
        //                               : Image.network(
        //                                   (chari.imageURL.first),
        //                                   fit: BoxFit.fill,
        //                                 ),
        //                           ListTile(
        //                             trailing: passiveUser.userImageURL.isEmpty
        //                                 ? const CircleAvatar(
        //                                     child: Icon(Icons.person))
        //                                 : CircleAvatar(
        //                                     backgroundImage: NetworkImage(
        //                                         passiveUser.userImageURL)),
        //                             title: Text(chari.brand),
        //                             subtitle: Text(
        //                               chari.frame,
        //                               style: TextStyle(
        //                                   color: Colors.black.withOpacity(0.6)),
        //                             ),
        //                           ),
        //                         ],
        //                       )));
        //             }),
        //       )
        //     ]));
      }, error: (Object error, StackTrace stackTrace) {
        return null;
      }, loading: () {
        return const Scaffold();
      }),
    );
  }
}
