import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';
import '/constants/routes.dart' as routes;

import '../../../domain/chari/chari.dart';
import '../../../domain/firestore_user/firestore_user.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chariUid}) : super(key: key);
  final String chariUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chariProviderFamily(chariUid));
    final chariDetailModel = ref.watch(chariDetailProvider);
    // print(state);
    state.when(
        data: (chari) {
          return Scaffold(
            appBar: AppBar(title: Text(chari.brand)),
          );
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {});

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                routes.toPassiveUserPage(context: context);
              },
              child: Text(''),
            ),
            // Center(
            //     child: Image.network(
            //   ('s'),
            // )),
          ],
        ));
  }
}
