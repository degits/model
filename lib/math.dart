import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Maths extends StatelessWidget {
  //default constructor = fromJson
  const Maths({Key? key, required this.text}) : super(key: key);
  final String text;

  //fromJson automatically call this and return
  @override
  Widget build(BuildContext context) {
    return Math.tex(
      text,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
