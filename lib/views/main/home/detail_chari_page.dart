import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constants/routes.dart' as routes;

import '../../../domain/chari/chari.dart';
import '../../../domain/firestore_user/firestore_user.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chari, required this.passiveUser}) : super(key: key);
  final Chari chari;
  final FirestoreUser passiveUser;

  // final FirestoreUser firestoreUser =
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(chari.brand),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                routes.toPassiveUserPage(context: context);
              },
              child: Text(chari.uid),
            ),
            Center(
                child: Image.network(
              (chari.imageURL[0]),
            )),
          ],
        ));
  }
}
