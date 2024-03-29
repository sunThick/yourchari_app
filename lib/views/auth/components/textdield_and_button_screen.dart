import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAndButtonScreen extends StatelessWidget {
  const TextFieldAndButtonScreen(
      {Key? key,
      required this.appbarTitle,
      required this.buttonText,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.onPressed})
      : super(key: key);

  final String appbarTitle, buttonText, hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(hintText),
              Center(
                child: TextField(
                  onChanged: onChanged,
                  controller: controller,
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
        ),
      ),
    );
  }
}
