import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/charis_model.dart';
import 'package:yourchari_app/models/detail_chari_model.dart';
import 'package:yourchari_app/models/main_model.dart';
import '../domain/chari/chari.dart';
import '/constants/routes.dart' as routes;
import 'package:carousel_slider/carousel_slider.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chariUid}) : super(key: key);
  final String chariUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chariProviderFamily(chariUid));
    final MainModel mainModel = ref.watch(mainProvider);
    final ChariDetailModel chariDetailModel = ref.watch(chariDetailProvider);
    final CharisModel charisModel = ref.watch(charisProvider);
    int current = chariDetailModel.currentIndex;
    final CarouselController _controller = CarouselController();

    return Scaffold(
        body: state.when(
            data: (chariAndPassiveUser) {
              final chariDoc = chariAndPassiveUser.item1;
              final passiveUser = chariAndPassiveUser.item2;
              final Chari chari = Chari.fromJson(chariDoc.data()!);
              final List<Widget> imageSliders = chari.imageURL
                  .map((item) => Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            child: chari.imageURL.length == 1
                                ? Image.network(item, fit: BoxFit.cover)
                                : Image.network(item,
                                    fit: BoxFit.cover, width: 1000.0)),
                      ))
                  .toList();

              // return Scaffold(
              //     appBar: AppBar(title: Text('tt')),
              //     body: Column(
              //       children: [Text('dd')],
              //     ));

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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ListTile(
                              title: Text(chari.brand),
                              subtitle: Text(chari.frame),
                              trailing:
                                  mainModel.likeChariIds.contains(chari.postId)
                                      ? InkWell(
                                          onTap: () async => charisModel.unlike(
                                              chari: chari,
                                              chariDoc: chariDoc,
                                              chariRef: chariDoc.reference,
                                              mainModel: mainModel),
                                          child: const Icon(
                                            Icons.heart_broken,
                                            color: Colors.red,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async => charisModel.like(
                                              chari: chari,
                                              chariDoc: chariDoc,
                                              chariRef: chariDoc.reference,
                                              mainModel: mainModel),
                                          child: const Icon(Icons.favorite),
                                        ))),
                      CarouselSlider(
                        items: imageSliders,
                        carouselController: _controller,
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
                                      .withOpacity(
                                          current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {},
            loading: () {
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
