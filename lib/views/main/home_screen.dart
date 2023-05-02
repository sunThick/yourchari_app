// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/main_model.dart';

import '../../domain/chari/chari.dart';
import '../../models/main/home_model.dart';
// constants

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
    required mainModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final chariDocs = homeModel.chariDocs;
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: homeModel.chariDocs.length,
        itemBuilder: (BuildContext context, int index) {
          final doc = chariDocs[index];
          final Chari chari = Chari.fromJson(doc.data()!);
          return Card(
            child: Center(child: Text(chari.brand)),
          );
        });
    // return ListView.builder(
    //   itemCount: homeModel.chariDocs.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     final doc = chariDocs[index];
    //     final Chari chari = Chari.fromJson(doc.data()!);
    //     return ListTile(
    //       title: Text(chari.brand),
    //     );
    //   },
    // );
  }
}
