import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';
import '/constants/routes.dart' as routes;

import '../domain/chari/chari.dart';
import '../domain/firestore_user/firestore_user.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chariUid}) : super(key: key);
  final String chariUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chariProviderFamily(chariUid));
    final ChariDetailModel chariDetailModel = ref.watch(chariDetailProvider);

    return Scaffold(
        body: state.when(
            data: (chariAndPassiveUser) {
              final chari = chariAndPassiveUser.item1;
              final passiveUser = chariAndPassiveUser.item2;
              return Scaffold(
                  appBar: AppBar(title: Text(chari.brand)),
                  body: Center(
                    child: Column(
                      children: [
                        Text(chariDetailModel.i.toString()),
                        ElevatedButton(
                          onPressed: () => routes.toPassiveUserPage(
                              context: context, userId: passiveUser.uid),
                          child: Text(passiveUser.userName),
                        ),
                        Text(passiveUser.userName)
                      ],
                    ),
                  ));
            },
            error: (Object error, StackTrace stackTrace) {},
            loading: () {
              return Scaffold(
                appBar: AppBar(),
              );
            }));
  }
}
