import 'package:flutter/material.dart';
 
class FinishedPage extends StatelessWidget {

  const FinishedPage({
    Key? key,
    required this.msg
  }) : super(key: key);
  final String msg;
 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(msg,style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold ),),
      )
    );
  }
}