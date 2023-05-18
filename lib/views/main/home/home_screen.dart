// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/main_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../constants/routes.dart';
import '../../../domain/chari/chari.dart';
import '../../../models/main/home_model.dart';
// constants

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
    required this.mainmodel,
  }) : super(key: key);
  final MainModel mainmodel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    print(homeModel);
    final chariDocs = homeModel.chariDocs;
    final userDocs = homeModel.userDocs;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/homeLogo.png',
          height: 40,
        ),
        backgroundColor: Colors.white,
      ),
      body: MasonryGridView.count(
          crossAxisCount: 2,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   mainAxisExtent: 250,
          // ),
          itemCount: homeModel.chariDocs.length,
          itemBuilder: (BuildContext context, int index) {
            final chariDoc = chariDocs[index];
            final userDoc = userDocs[index];
            final Chari chari = Chari.fromJson(chariDoc.data()!);
            final FirestoreUser passiveUser =
                FirestoreUser.fromJson(userDoc.data()!);
            return InkWell(
              onTap: () {
                toChariDetailPage(context: context, chariUid: chari.postId);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      // leading: passiveUser.userImageURL.isEmpty
                      //     ? const CircleAvatar(child: Icon(Icons.person))
                      //     : CircleAvatar(
                      //         backgroundImage:
                      //             NetworkImage(passiveUser.userImageURL)),
                      title: Text(chari.brand),
                      subtitle: Text(
                        chari.frame,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    // Image.network(
                    //   (chari.imageURL[0]),
                    //   height: 150,
                    //   fit: BoxFit.fill,
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
