import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model/admin/question.dart';
import 'admin/lines/sentence.dart';

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

  String getReloadingString() {
//Paste your question here
return """
->q 22
->img <url>https://images.unsplash.com/photo-1644301467387-d85f3ca1e6a9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=10</url> <width>100</width> <height>50</height>
->sub (a)
*m*4*/m*  
*c*My Code*/c* Hello World!
""";
}

  @override
  Widget build(BuildContext context) {
    
    Map<String, dynamic> q = AdminQuestion.fromString(getReloadingString()).toJson();
    String json = jsonEncode(q);
    print(json);
    return Scaffold(
      
      appBar: AppBar(),
      body: Center(
        child: Text("$q"),
      )
    );
  }
  
}