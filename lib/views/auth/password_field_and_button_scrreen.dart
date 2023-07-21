import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewModels/form_obsucure_controller.dart';

class PasswordFieldAndButtonScreen extends ConsumerWidget {
  const PasswordFieldAndButtonScreen(
      {Key? key,
      required this.appbarTitle,
      required this.buttonText,
      required this.hintText,
      required this.textEditingController,
      required this.onChanged,
      required this.onPressed})
      : super(key: key);

  final String appbarTitle, buttonText, hintText;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = ref.watch(formObscureNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(hintText),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                onChanged: onChanged,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffix: InkWell(
                      child: isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onTap: () {
                        ref.read(formObscureNotifier.notifier).toggle();
                      }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          )
        ],
      ),
    );
  }
}
