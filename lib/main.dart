import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model/sentence.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sentence s1 = Sentence.fromJson(line: "*m*code1*/m*Y*b*code1*/b*Y*b*code1*/b*",);
    
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: s1,
      ),
    );
  }
  
}