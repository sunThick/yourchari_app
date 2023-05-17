// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/models/main_model.dart';

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
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: homeModel.chariDocs.length,
          itemBuilder: (BuildContext context, int index) {
            final chariDoc = chariDocs[index];
            final userDoc = userDocs[index];
            final Chari chari = Chari.fromJson(chariDoc.data()!);
            final FirestoreUser passiveUser =
                FirestoreUser.fromJson(userDoc.data()!);
            return InkWell(
              onTap: () {
                toChariDetailPage(
                    context: context, chari: chari, passiveUser: passiveUser);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(passiveUser.userName),
                    Center(
                        child: Image.network(
                      (chari.imageURL[0]),
                    )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
