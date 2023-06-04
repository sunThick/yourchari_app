// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/routes.dart';
// constants

class SearchScreen extends ConsumerWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
