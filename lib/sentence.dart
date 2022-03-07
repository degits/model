import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Sentence extends StatelessWidget {
  Sentence({Key? key, required this.line}) : super(key: key);

  //fromJson       return widget
  //fromString     return widget    default constructor
  //toJson         return map/list...
  //String? content;
  final String line;

  //!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // fromJson / fromString
  //!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Sentence.fromJson({Key? key, required this.line}) : super(key: key) {
    String mutableLine = line;
    int startIndex = 0;
    int endIndex;

    while (true) {
    startIndex = mutableLine.indexOf("*");
    //print("StartIndex: $startIndex");
    if (startIndex == -1) {
      //No more tags remain
      break;
    } else if (mutableLine[startIndex + 1] == "m") {
      //It's a math
      endIndex = mutableLine.indexOf("*", startIndex + 3);
      //print("endIndex: $endIndex");
      if (mutableLine[endIndex + 1] == "/" && mutableLine[endIndex + 2] == "m") {
        String replacement = "";
        String subString = mutableLine.substring(startIndex + 3, endIndex);
        for (int i = 0; i < subString.length + 7; i++) {
          replacement = replacement + "^";
        }
        mutableLine = mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
      } else {
        print("❌❌sentence.dart > ERROR(math tag): Unclosed or closed with diffrent tag found ❌❌");
        break;//!now added
      }

    } else if (line[startIndex + 1] == "c") {
      //It's a code
      endIndex = mutableLine.indexOf("*", startIndex + 3);
      //print("endIndex: $endIndex");
      if (mutableLine[endIndex + 1] == "/" && mutableLine[endIndex + 2] == "c") {
        String replacement = "";
        String subString = mutableLine.substring(startIndex + 3, endIndex);
        for (int i = 0; i < subString.length + 7; i++) {
          replacement = replacement + "^";
        }
        mutableLine = mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
      } else {
        if (kDebugMode) {
          print("❌❌sentence.dart > ERROR(code tag): Unclosed or closed with diffrent tag found ❌❌");
          break;//!now added
        }
      }
    } else if (line[startIndex + 1] == "b") {
      //It's a bold
      endIndex = mutableLine.indexOf("*", startIndex + 3);
      //print("endIndex: $endIndex");
      if (mutableLine[endIndex + 1] == "/" && mutableLine[endIndex + 2] == "b") {
        String replacement = "";
        String subString = mutableLine.substring(startIndex + 3, endIndex);
        for (int i = 0; i < subString.length + 7; i++) {
          replacement = replacement + "^";
        }
        mutableLine = mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
      } else {
        if (kDebugMode) {
          print("❌❌sentence.dart > ERROR(bold tag): Unclosed or closed with diffrent tag found ❌❌");
          break;//!now added
        }
      }
    } else {
      if (kDebugMode) {
        print("❌❌sentence.dart > ERROR: Untagged Astrix(*) found ❌❌");
        break;//!now added
      }
    }
    print(mutableLine);
    }
  }
  //!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  /*//fromString
  Sentence.fromString(String content, {Key? key}) : super(key: key) {
    content = content;
  }*/

  //toJson
  Map<dynamic, dynamic> toJson() {
    return {};
  }

  @override
  Widget build(BuildContext context) {
    // 1. check null
    return Center();
  }
}
