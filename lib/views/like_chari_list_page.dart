import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/views/components/components.dart';

import '../constants/routes.dart';
import '../domain/chari/chari.dart';
import '../models/like_chari_list_model.dart';

class LikeChariListPage extends ConsumerWidget {
  const LikeChariListPage({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final AsyncValue<
            Tuple2<List<DocumentSnapshot<Map<String, dynamic>>>,
                List<DocumentSnapshot<Map<String, dynamic>>>>> config =
        ref.watch(likeChariDocsProvider(uid));
    return config.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (data) {
        final chariDocs = data.item1;
        final userDocs = data.item2;
        return Scaffold(
          appBar: AppBar(title: const Text('いいねした自転車')),
          body: RefreshIndicator(
            onRefresh: () async {
              // ignore: unused_result
              ref.refresh(likeChariDocsProvider(uid));
            },
            child: MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: chariDocs.length,
                itemBuilder: (BuildContext context, int index) {
                  final chariDoc = chariDocs[index];
                  final userDoc = userDocs[index];
                  if (chariDoc.data() == null || userDoc.data() == null) {
                    return Container();
                  }
                  final Chari chari = Chari.fromJson(chariDoc.data()!);
                  final FirestoreUser passiveUser =
                      FirestoreUser.fromJson(userDoc.data()!);
                  return InkWell(
                      onTap: () {
                        toChariDetailPage(
                            context: context, chariUid: chari.postId);
                      },
                      onDoubleTap: () {},
                      child: homeCard(
                          chari: chari,
                          passiveUser: passiveUser,
                          mainController: mainController));
                }),
          ),
        );
      },
    );
  }
}
