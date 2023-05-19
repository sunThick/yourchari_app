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
    // print(state);
    state.when(
        data: (data) {
          final Chari chari = Chari.fromJson(data!);
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {});

    // final chaiDoc = chariDetailModel.chariDoc;

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
