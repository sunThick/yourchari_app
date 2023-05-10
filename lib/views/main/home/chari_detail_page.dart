import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/chari_detail_model.dart';

import '../../../domain/chari/chari.dart';

class ChariDetailPage extends ConsumerWidget {
  const ChariDetailPage({Key? key, required this.chari}) : super(key: key);
  final Chari chari;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChariDetailModel chariDetailModel = ref.watch(chariDetailProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(chari.brand),
        ),
        body: Center(
            child: Image.network(
          (chari.imageURL[0]),
        )));
  }
}
