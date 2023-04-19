import 'package:flutter/material.dart';
import '../../../models/chari.dart';

class ChariDetailPage extends StatelessWidget {
  final Chari chari;
  const ChariDetailPage(this.chari, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(chari.brand)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'chari詳細',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(chari.frame),
            ],
          ),
        ));
  }
}
