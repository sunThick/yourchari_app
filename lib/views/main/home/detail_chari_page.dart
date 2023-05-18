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
    // final tomato = ref.read(chariProviderFamily(chariUid).notifier).;
    // final chariDoc = chariDetailModel.
    // final chariDoc = chariDetailModel.chariDoc;
    // final Chari chari = Chari.fromJson(chariDoc.data()!);

    final state = ref.watch(chariProviderFamily(chariUid));
    // print(state);
    state.when(
        data: (data) {
          final Chari chari = Chari.fromJson(data.data()!);
          print(chari.brand);
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {});
    // final Chari chari = Chari.fromJson(state.value())

    // print(state.chariDoc);
    // final chari = chariDetailModel
    // ref.watch(tomato).when(
    //     data: (data) => Text(data.toString()),
    //     error: (error, stackTrace) => Text(stackTrace.toString()),
    //     loading: () => const CircularProgressIndicator());
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
              child: Text('d'),
            ),
            // Center(
            //     child: Image.network(
            //   ('s'),
            // )),
          ],
        ));
  }
}
