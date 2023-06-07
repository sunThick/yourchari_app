import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passiveUserFamily(userId));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);
    final ProfileModel profileModel = ref.watch(profileProvider);
    final MainModel mainModel = ref.watch(mainProvider);
    const double headerHeight = 90;

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
                SizedBox(
                  height: headerHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // croppedfileがなければcloudstorageのファイルを表示
                          child: profileModel.croppedFile != null
                              ? CircleAvatar(
                                  radius: headerHeight / 2,
                                  backgroundImage:
                                      Image.file(profileModel.croppedFile!)
                                          .image,
                                )
                              : Container(
                                  // croppedfileがなければcloudstorageのファイルを表示
                                  child: passiveUser.userImageURL.isEmpty
                                      ? const CircleAvatar(
                                          radius: headerHeight / 2,
                                          child: Icon(Icons.person))
                                      : CircleAvatar(
                                          radius: headerHeight / 2,
                                          backgroundImage: NetworkImage(
                                              mainModel
                                                  .firestoreUser.userImageURL)),
                                ),
                        ),
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
                            buildButton(text: 'chari', value: chariDocs.length),
                            InkWell(
                              onTap: () => {},
                              child: buildButton(
                                  text: 'follwing',
                                  value: passiveUser.followingCount),
                            ),
                            InkWell(
                              onTap: () => {},
                              child: buildButton(
                                  text: 'follwers',
                                  value: passiveUserModel.plusOne
                                      ? plusOneFollowerCount
                                      : passiveUserModel.minusOne
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
                                  onPressed: () => passiveUserModel.unfollow(
                                      mainModel: mainModel,
                                      passiveUser: passiveUser),
                                  child: const Text('following'),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    //ボタンの背景色
                                  ),
                                  onPressed: () => passiveUserModel.follow(
                                      mainModel: mainModel,
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
                    initialIndex: passiveUserModel.currentIndex,
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black12,
                          tabs: [Tab(text: "Chari"), Tab(text: "Likes")],
                          onTap: (index) {
                            passiveUserModel.changePage(index);
                          },
                        ),
                      ],
                    )),
                passiveUserModel.currentIndex == 0
                    ? Expanded(
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
                      )
                    : Text('likes')
              ],
            ));
      }, error: (Object error, StackTrace stackTrace) {
        return null;
      }, loading: () {
        return const Scaffold();
      }),
    );
  }
}
