import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/chari_like_controller.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/mute_users_controller.dart';
import '../constants/routes.dart';
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
    final MuteUsersController muteUsersController =
        ref.watch(muteUsersProvider);
    final ChariDetailPageController chariDetailModel =
        ref.watch(chariDetailNotifierProvider);
    final ChariLikeController chariLikeController =
        ref.watch(chariLikeProvider);

    final CarouselController controller = CarouselController();

    int current = chariDetailModel.currentIndex;

    return Scaffold(
        body: state.when(data: (chariAndPassiveUser) {
      final chariDoc = chariAndPassiveUser.item1;
      final passiveUser = chariAndPassiveUser.item2;
      final Chari chari = Chari.fromJson(chariDoc.data()!);
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

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _showActionSheet(context,
                    mainController: mainController,
                    muteUsersController: muteUsersController,
                    passiveUid: passiveUser.uid);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (mainController.muteUids.contains(passiveUser.uid))
                const Text('このユーザーは現在ミュートしています。'),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListTile(
                      title: Text(chari.brand),
                      subtitle: Text(chari.frame),
                      trailing:
                          mainController.likeChariIds.contains(chari.postId)
                              ? InkWell(
                                  onTap: () async => chariLikeController.unlike(
                                      chari: chari,
                                      chariDoc: chariDoc,
                                      chariRef: chariDoc.reference,
                                      mainController: mainController),
                                  child: const Icon(
                                    Icons.heart_broken,
                                    color: Colors.red,
                                  ),
                                )
                              : InkWell(
                                  onTap: () async => chariLikeController.like(
                                      chari: chari,
                                      chariDoc: chariDoc,
                                      chariRef: chariDoc.reference,
                                      mainController: mainController),
                                  child: const Icon(Icons.favorite),
                                ))),
              CarouselSlider(
                items: imageSliders,
                carouselController: controller,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      chariDetailModel.changeImage(index);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: chari.imageURL.asMap().entries.map((entry) {
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
                              .withOpacity(current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              InkWell(
                onTap: () async => toPassiveUserPage(
                    context: context, userId: passiveUser.uid),
                child: ListTile(
                  leading: passiveUser.userImageURL.isEmpty
                      ? const CircleAvatar(child: Icon(Icons.person))
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(passiveUser.userImageURL)),
                  title: Text(passiveUser.userName),
                ),
              )
            ],
          ),
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

  void _showActionSheet(BuildContext context,
      {required MainController mainController,
      required MuteUsersController muteUsersController,
      required String passiveUid}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        // title: const Text('Title'),
        // message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {},
            child: const Text('Default Action'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              mainController.muteUids = [];
              print(mainController.muteUids);
            },
            child: const Text('Action'),
          ),
          CupertinoActionSheetAction(

              /// This parameter indicates the action would perform
              /// a destructive action such as delete or exit and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                _showAlertDialog(context,
                    mainController: mainController,
                    muteUsersController: muteUsersController,
                    passiveUid: passiveUid);
              },
              child: mainController.muteUids.contains(passiveUid)
                  ? const Text('ミュートを解除')
                  : const Text('このユーザーをミュート')),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context,
      {required MuteUsersController muteUsersController,
      required MainController mainController,
      required String passiveUid}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('ss'),
        // content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              muteUsersController.muteUser(
                  mainController: mainController, passiveUid: passiveUid);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
