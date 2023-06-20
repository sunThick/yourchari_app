import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/mute_users_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';
import 'package:yourchari_app/viewModels/mute_users_controller.dart';

class MuteUsersPage extends ConsumerWidget {
  const MuteUsersPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muteUserDocs = ref.watch(muteUsersProvider(uid));
    final UserMuteController userMuteController = ref.watch(userMuteProvider);
    final MainController mainController = ref.watch(mainProvider);
    return muteUserDocs.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (muteUserDocs) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('ミュートしたユーザー'),
            ),
            body: ListView.builder(
              itemCount: muteUserDocs.length,
              itemBuilder: (context, index) {
                final muteUserDoc = muteUserDocs[index];
                final FirestoreUser muteUser =
                    FirestoreUser.fromJson(muteUserDoc.data()!);
                return ListTile(
                  leading: muteUser.userImageURL.isNotEmpty
                      ? CircleAvatar(
                          child: Image.network(muteUser.userImageURL),
                        )
                      : const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                  title: Text(muteUser.userName),
                  trailing: ElevatedButton(
                    child: Text('ミュートを解除'),
                    onPressed: () {
                      userMuteController.unMuteUser(
                          mainController: mainController,
                          passiveUid: muteUser.uid,
                          muteUserDoc: muteUserDoc,
                          muteUserDocs: muteUserDocs);
                    },
                  ),
                );
              },
            ));
      },
    );
  }
}
