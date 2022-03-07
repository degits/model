import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  //default constructor = fromJson
  const Code({Key? key, required this.text}) : super(key: key);
  final String text;

  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
    );
  }
}
