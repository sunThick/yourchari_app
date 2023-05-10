// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/main/profile_model.dart';

import '../../constants/routes.dart';
// constants

class SearchScreen extends ConsumerWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ProfileModel();
    return Column(
      children: [
        FloatingActionButton(
          onPressed: () => toCreateChariPage(context: context),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
