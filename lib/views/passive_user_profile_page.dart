import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';

import '../domain/firestore_user/firestore_user.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({required this.userId, Key? key})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passiveUserProviderFamily(userId));
    final PassiveUserModel passiveUserModel = ref.watch(passiveUserProvider);

    return Scaffold(
      body: state.when(
          data: (passiveUserAndCharis) {
            final passiveUser = passiveUserAndCharis.item1;
            final chariDocs = passiveUserAndCharis.item2;
            return Scaffold(
              appBar: AppBar(),
              body: Column(children: [Text(passiveUser.userName)]),
            );
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {
            return Scaffold(
              appBar: AppBar(),
            );
          }),
    );
  }
}
