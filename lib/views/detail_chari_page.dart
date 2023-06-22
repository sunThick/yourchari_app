import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/chari_like_controller.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/mute_users_controller.dart';
import '../constants/routes.dart';
import '../constants/dialog.dart';
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (mainController.muteUids.contains(passiveUser.uid))
                const Text('このユーザーは現在ミュートしています。'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      passiveUser.userImageURL.isEmpty
                          ? const CircleAvatar(child: Icon(Icons.person))
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(passiveUser.userImageURL)),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text(passiveUser.userName),
                        onTap: () async => toPassiveUserPage(
                            context: context, userId: passiveUser.uid),
                      )
                    ]),
                    InkWell(
                        child: const Icon(Icons.more_vert),
                        onTap: () {
                          chariPassiveSheet(context,
                              mainController: mainController,
                              muteUsersController: muteUsersController,
                              passiveUid: passiveUser.uid);
                        })
                  ],
                ),
              ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chari.brand,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            chari.frame,
                            style: const TextStyle(fontSize: 23),
                          )
                        ],
                      ),
                      mainController.likeChariIds.contains(chari.postId)
                          ? InkWell(
                              onTap: () async => chariLikeController.unlike(
                                  chari: chari,
                                  chariDoc: chariDoc,
                                  chariRef: chariDoc.reference,
                                  mainController: mainController),
                              child: const Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              ),
                            )
                          : InkWell(
                              onTap: () async => chariLikeController.like(
                                  chari: chari,
                                  chariDoc: chariDoc,
                                  chariRef: chariDoc.reference,
                                  mainController: mainController),
                              child: const Icon(
                                CupertinoIcons.heart,
                              ),
                            )
                    ]),
              ),
              const Divider(height: 10),
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
        ),
      );
    }));
  }
}
