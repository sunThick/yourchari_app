import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/viewModels/inquiry_page_controller.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

class InquiryPage extends ConsumerWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InquiryPageController inquiryPageController =
        ref.watch(inquiryProvider);
    final MainController mainController = ref.watch(mainProvider);
    final FirestoreUser firestoreUser = mainController.currentFirestoreUser;
    return Scaffold(
      appBar: AppBar(title: const Text('お問い合わせ')),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'お問い合わせ内容',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (inquiryPageController.contentRequired)
                  const Text(
                    '入力してください。',
                    style: TextStyle(color: Colors.red),
                  ),
                TextFormField(
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  controller: inquiryPageController.inquiryEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      inquiryPageController.createInquiry(
                          firestoreUser: firestoreUser);
                    },
                    child: const Text('送信'))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
