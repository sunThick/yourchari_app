import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/chari_like_controller.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';
import 'package:yourchari_app/viewModels/create_chari_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/mute_users_controller.dart';
import 'package:yourchari_app/views/components/components.dart';
import '../constants/routes.dart';
import '../constants/dialog.dart';
import '../constants/string.dart';
import '../domain/chari/chari.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../viewModels/detail_chari_page_controller.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chariUid}) : super(key: key);
  final String chariUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chariDetailProvider(chariUid));
    final MainController mainController = ref.watch(mainProvider);
    final UserMuteController muteUsersController = ref.watch(userMuteProvider);
    final DetailChariPageController detailChariPageController =
        ref.watch(chariDetailNotifierProvider);
    final ChariLikeController chariLikeController =
        ref.watch(chariLikeProvider);
    final CreateChariController createChariController =
        ref.watch(createChariProvider);
    final CarouselController controller = CarouselController();
    int current = detailChariPageController.currentIndex;
    return Scaffold(
        body: state.when(data: (chariAndPassiveUser) {
      final chariDoc = chariAndPassiveUser.item1;
      final passiveUserDoc = chariAndPassiveUser.item2;
      if (chariDoc.data() == null) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text("この投稿は削除されています")),
        );
      }
      final Chari chari = Chari.fromJson(chariDoc.data()!);

      final FirestoreUser passiveUser =
          FirestoreUser.fromJson(passiveUserDoc.data()!);
      //  写真
      final List<Widget> imageSliders = chari.imageURL
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: chari.imageURL.length == 1
                        ? Image.network(item, fit: BoxFit.cover)
                        : Image.network(item,
                            fit: BoxFit.cover, width: 1000.0)),
              ))
          .toList();
      if (mainController.muteUids.contains(passiveUser.uid)) {
        return Scaffold(
          appBar: AppBar(title: const Text('投稿')),
          body: const Center(child: Text('このユーザーの投稿は現在ミュートしています')),
        );
      }

      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('投稿'),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                // ignore: unused_result
                ref.refresh(chariDetailProvider(chariUid));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //----------------------ユーザー情報-----------------------------------------------
                      StickyHeader(
                        header: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                buildAvatarImage(
                                    passiveUser: passiveUser,
                                    currentFirestoreUser:
                                        mainController.currentFirestoreUser,
                                    radius: 20),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Text(passiveUser.userName),
                                  onTap: () async => toPassiveUserPage(
                                      context: context,
                                      userId: passiveUser.uid),
                                )
                              ]),
                              InkWell(
                                  child: const Icon(Icons.more_vert),
                                  onTap: () {
                                    chariPassiveSheet(context,
                                        mainController: mainController,
                                        muteUsersController:
                                            muteUsersController,
                                        passiveUid: passiveUser.uid,
                                        chariDoc: chariDoc,
                                        createChariController:
                                            createChariController,
                                        detailChariPageContext: context,
                                        detailChariPageController:
                                            detailChariPageController,
                                        passiveUser: passiveUser);
                                  })
                            ],
                          ),
                        ),
                        content: Column(children: [
                          CarouselSlider(
                            items: imageSliders,
                            carouselController: controller,
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                detailChariPageController.changeImage(index);
                              },
                              enableInfiniteScroll: false,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                chari.imageURL.asMap().entries.map((entry) {
                              return GestureDetector(
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //-----------------------自転車の情報------------------------//
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '"${chari.brand}"',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        chari.frame,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        createTimeAgoString(
                                            chari.createdAt.toDate()),
                                        style: const TextStyle(
                                            color: Colors.black45)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    mainController.likeChariIds
                                            .contains(chari.postId)
                                        ? InkWell(
                                            onTap: () async => {
                                              chariLikeController.unlike(
                                                  chari: chari,
                                                  chariDoc: chariDoc,
                                                  chariRef: chariDoc.reference,
                                                  mainController:
                                                      mainController),
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3, right: 3),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.heart_fill,
                                                    color: Colors.red,
                                                  ),
                                                  Text(chari.likeCount
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async =>
                                                chariLikeController.like(
                                                    chari: chari,
                                                    chariDoc: chariDoc,
                                                    chariRef:
                                                        chariDoc.reference,
                                                    mainController:
                                                        mainController),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3, right: 3),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.heart,
                                                  ),
                                                  Text(chari.likeCount
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider(height: 30),
                          if (chari.caption != "")
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'caption',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(chari.caption),
                                    ],
                                  ),
                                  const Divider(height: 30),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: const Row(
                              children: [
                                Text(
                                  'parts list',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          partsList(chari: chari, context: context),
                          const SizedBox(
                            height: 50,
                          )
                        ]),
                      ),
                      // const SizedBox(height: 10),
                      //-----------------------写真のスライダー--------------------------------//
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (createChariController.isDeleting)
            ColoredBox(
              color: Colors.black54,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createChariController.isDeleted
                      ? const Icon(
                          Icons.done,
                          size: 100,
                          color: Colors.blue,
                        )
                      : const CircularProgressIndicator()
                ],
              )),
            ),
        ],
      );
    }, error: (Object error, StackTrace stackTrace) {
      return null;
    }, loading: () {
      return Scaffold(
        appBar: AppBar(),
      );
    }));
  }

  Widget partsList({required Chari chari, required context}) {
    return Column(
      children: [
        if (chari.fork != null)
          partTile(context: context, part: chari.fork, partName: 'fork'),
        if (chari.headSet != null)
          partTile(context: context, part: chari.headSet, partName: 'head set'),
        if (chari.columnSpacer != null)
          partTile(
              context: context,
              part: chari.columnSpacer,
              partName: 'column spacer'),
        if (chari.handleBar != null)
          partTile(
              context: context, part: chari.handleBar, partName: 'handle bar'),
        if (chari.stem != null)
          partTile(context: context, part: chari.stem, partName: 'stem'),
        if (chari.grip != null)
          partTile(context: context, part: chari.grip, partName: 'grip'),
        if (chari.saddle != null)
          partTile(context: context, part: chari.saddle, partName: 'saddle'),
        if (chari.seatPost != null)
          partTile(
              context: context, part: chari.seatPost, partName: 'seat post'),
        if (chari.seatClamp != null)
          partTile(
              context: context, part: chari.seatClamp, partName: 'seat clamp'),
        if (chari.tire != null)
          partTile(context: context, part: chari.tire, partName: 'tire'),
        if (chari.rim != null)
          partTile(context: context, part: chari.rim, partName: 'rim'),
        if (chari.hub != null)
          partTile(context: context, part: chari.hub, partName: 'hub'),
        if (chari.cog != null)
          partTile(context: context, part: chari.cog, partName: 'cog'),
        if (chari.sprocket != null)
          partTile(
              context: context, part: chari.sprocket, partName: 'sprocket'),
        if (chari.lockRing != null)
          partTile(
              context: context, part: chari.lockRing, partName: 'lock ring'),
        if (chari.freeWheel != null)
          partTile(
              context: context, part: chari.freeWheel, partName: 'free wheel'),
        if (chari.crank != null)
          partTile(context: context, part: chari.crank, partName: 'crank'),
        if (chari.chainRing != null)
          partTile(
              context: context, part: chari.chainRing, partName: 'chain ring'),
        if (chari.chain != null)
          partTile(context: context, part: chari.chain, partName: 'chain'),
        if (chari.bottomBrancket != null)
          partTile(
              context: context,
              part: chari.bottomBrancket,
              partName: 'bottom brancket'),
        if (chari.pedals != null)
          partTile(context: context, part: chari.pedals, partName: 'pedals'),
        if (chari.brake != null)
          partTile(context: context, part: chari.brake, partName: 'brake'),
        if (chari.brakeLever != null)
          partTile(
              context: context,
              part: chari.brakeLever,
              partName: 'brake lever'),
        if (chari.shifter != null)
          partTile(context: context, part: chari.shifter, partName: 'shifter'),
        if (chari.shiftLever != null)
          partTile(
              context: context,
              part: chari.shiftLever,
              partName: 'shift lever'),
        if (chari.rack != null)
          partTile(context: context, part: chari.rack, partName: 'rack'),
        if (chari.bottle != null)
          partTile(context: context, part: chari.bottle, partName: 'bottle'),
        if (chari.frontLight != null)
          partTile(
              context: context,
              part: chari.frontLight,
              partName: 'front light'),
        if (chari.rearLight != null)
          partTile(
              context: context, part: chari.rearLight, partName: 'rear light'),
        if (chari.lock != null)
          partTile(context: context, part: chari.lock, partName: 'lock'),
        if (chari.bell != null)
          partTile(context: context, part: chari.bell, partName: 'bell'),
        if (chari.helmet != null)
          partTile(context: context, part: chari.helmet, partName: 'helmet'),
        if (chari.bag != null)
          partTile(context: context, part: chari.bag, partName: 'bag'),
        if (chari.basket != null)
          partTile(context: context, part: chari.basket, partName: 'basket'),
      ],
    );
  }

  Widget partTile(
      {required context, required List<dynamic>? part, required partName}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(children: [
          Expanded(
              flex: 3,
              child: Wrap(children: [
                Text(
                  partName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ])),
          Expanded(
              flex: 7,
              child: Wrap(
                children: [
                  Text(
                    '"${part!.first}"',
                    // style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    part.last,
                    // style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
