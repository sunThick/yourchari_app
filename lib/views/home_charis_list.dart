import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/category_models.dart';

class CharisList extends ConsumerWidget {
  const CharisList({Key? key, required this.index}) : super(key: key);
  // @override
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<int, String> categoryMap = {
      0: 'all',
      1: 'single',
      2: 'mini',
      3: 'touring',
      4: 'roal',
      5: 'mini',
      6: 'mamachari',
      7: 'others',
    };

    final asyncValue = ref.watch(categoryF(categoryMap[index]!));
    return Scaffold(
      body: Center(
        child: asyncValue.when(
          error: (err, _) => Text(err.toString()), //エラー時
          loading: () => const CircularProgressIndicator(), //読み込み時
          data: (data) => Text(
            '${data.toString()}',
            style: TextStyle(fontSize: 50, color: Colors.pink),
          ), //データ受け取り時
        ),
      ),
    );
  }
}
