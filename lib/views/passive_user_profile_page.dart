import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:yourchari_app/models/passive_user_profile_model.dart';

import '../domain/firestore_user/firestore_user.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({
    Key? key,
    // required this.passiveUser,
    // required this.mainModel,
  }) : super(key: key);
  // final FirestoreUser passiveUser;
  // final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final PassiveUserProfileModel passiveUserProfileModel =
    //     ref.watch(passiveUserProfileProvider);
    // final bool isFollowing = mainModel.followingUids.contains(passiveUser.uid);
    // final int followerCount = passiveUser.followerCount;
    // final int plusOneFollowerCount = followerCount + 1;
    return Scaffold(appBar: AppBar(title: Text('o')));
  }
}
