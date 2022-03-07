import 'package:flutter/material.dart';

class Bold extends StatelessWidget {
  //default constructor = fromJson
  const Bold({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    );
  }
}
