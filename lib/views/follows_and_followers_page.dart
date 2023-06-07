import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yourchari_app/models/followers_and_follows_model.dart';

class FollowsAndFollowersPage extends ConsumerWidget {
  const FollowsAndFollowersPage(
      {Key? key, required this.userUid, required this.followingOrFollowers})
      : super(key: key);
  final String userUid;
  final String followingOrFollowers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t2 = Tuple2<String, String>(userUid, followingOrFollowers);
    final state = ref.watch(followersOrFollowsFamily(t2));

    return Scaffold(
        body: state.when(data: (state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(followingOrFollowers),
        ),
        body: ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state[index].userName),
            );
          },
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return null;
    }, loading: () {
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
