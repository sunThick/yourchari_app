import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourchari_app/constants/routes.dart';

class CompleteInquilyPage extends StatelessWidget {
  const CompleteInquilyPage({Key? key, required this.content})
      : super(key: key);

  final String content;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'お問い合わせありがとうございます。1週間以内にご登録のメールアドレス宛に返信させていただきます。',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('お問い合わせ内容'),
                    Divider(),
                    Text(content),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
