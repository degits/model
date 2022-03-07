import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model/bold.dart';
import 'package:model/math.dart';
import 'package:model/word.dart';

import 'code.dart';

class Sentence extends StatelessWidget {
  Sentence({Key? key, required this.line}) : super(key: key);

  //fromJson       return widget
  //fromString     return widget    default constructor
  //toJson         return map/list...
  //String? content;
  final String line;

  //toJson
  Map<dynamic, dynamic> toJson() {
    return {};
  }

  @override
  Widget build(BuildContext context) {
    //!  common variables
    String mutableLine = line;
    List<WidgetSpan> taggedParts = [];
    List<WidgetSpan> sentenceAllPartsInOrder = []; //taggedParts + wordParts

    //!  closure function - 1 declaration
    void extractTaggedParts() {
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
          if (mutableLine[endIndex + 1] == "/" &&
              mutableLine[endIndex + 2] == "m") {
            String replacement = "";
            String subString = mutableLine.substring(startIndex + 3, endIndex);
            for (int i = 0; i < subString.length + 7; i++) {
              replacement = replacement + "^";
            }
            mutableLine =
                mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
            //!-----V2 -ON WORKING-----
            taggedParts.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Maths(text: subString),
              ),
            );
            //!--------------------
          } else {
            print(
                "❌❌sentence.dart > ERROR(math tag): Unclosed or closed with diffrent tag found ❌❌");
            break;
          }
        } else if (line[startIndex + 1] == "c") {
          //It's a code
          endIndex = mutableLine.indexOf("*", startIndex + 3);
          //print("endIndex: $endIndex");
          if (mutableLine[endIndex + 1] == "/" &&
              mutableLine[endIndex + 2] == "c") {
            String replacement = "";
            String subString = mutableLine.substring(startIndex + 3, endIndex);
            for (int i = 0; i < subString.length + 7; i++) {
              replacement = replacement + "^";
            }
            mutableLine =
                mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
            //!-----V2 -ON WORKING-----
            taggedParts.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Code(text: subString),
              ),
            );
            //!--------------------
          } else {
            if (kDebugMode) {
              print(
                  "❌❌sentence.dart > ERROR(code tag): Unclosed or closed with diffrent tag found ❌❌");
              break;
            }
          }
        } else if (line[startIndex + 1] == "b") {
          //It's a bold
          endIndex = mutableLine.indexOf("*", startIndex + 3);
          //print("endIndex: $endIndex");
          if (mutableLine[endIndex + 1] == "/" &&
              mutableLine[endIndex + 2] == "b") {
            String replacement = "";
            String subString = mutableLine.substring(startIndex + 3, endIndex);
            for (int i = 0; i < subString.length + 7; i++) {
              replacement = replacement + "^";
            }
            mutableLine =
                mutableLine.replaceRange(startIndex, endIndex + 4, replacement);
            //!-----V2 -ON WORKING-----
            taggedParts.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Bold(text: subString),
              ),
            );
            //!--------------------
          } else {
            if (kDebugMode) {
              print(
                  "❌❌sentence.dart > ERROR(bold tag): Unclosed or closed with diffrent tag found ❌❌");
              break;
            }
          }
        } else {
          if (kDebugMode) {
            print("❌❌sentence.dart > ERROR: Untagged Astrix(*) found ❌❌");
            break;
          }
        }
        //print("mutableLine after extractTaggedParts method: $mutableLine");
      }
    }

    //!  closure function - 2 declaration
    //declaration
    void extractAllParts() {
      int countForTaggedPartList = 0;
      List<String> splittedMutuableLine = mutableLine.split(" ");
      print("splittedMutuableLine:  $splittedMutuableLine");

      for (int i = 0; i < splittedMutuableLine.length; i++) {
        //print("splitttedPart index: $i  =${splittedMutuableLine[i]}");
        //!  ⚠️isEmpty is must ⚠️
        if (splittedMutuableLine[i].isEmpty) {
          print("Empty part==============");
          //!  ----v3 working----------
          sentenceAllPartsInOrder.add(
            const WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Word(text: " "),
            ),
          );
          //!  ------------------------
          print("index=$i isEmpty true");
        } else if (splittedMutuableLine[i][0] == "^") {
          print("Tagged part================");
          print("index=$i is a '^^^^^....'");
          //!  Below if condtion is Use for avoiding this -> "^^^^^^^^^^^^XXX" error.
          //?  ERROR: Missing forward space between tag and word
          for (int c = 0; c < splittedMutuableLine[i].length; c++) {
            if (splittedMutuableLine[i][c] != "^") {
              if (kDebugMode) {
                print(
                    "❌❌sentence.dart > ERROR: Missing forward space of the word in : ${splittedMutuableLine[i]} ❌❌");
                break;
              }
            }
          }
          //!  ----v3 working----------
          sentenceAllPartsInOrder.add(taggedParts[countForTaggedPartList]);
          //For adding space
          sentenceAllPartsInOrder.add(
            const WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Word(text: " "),
            ),
          );
          //!  ------------------------
        } else {
          print("Word part===============");
          //!  Below if condtion is Use for avoiding this -> "XXX^^^^^^^^^^^^" error.
          //?  ERROR: Missing backward space between tag and word
          if (splittedMutuableLine[i].contains("^")) {
            if (kDebugMode) {
              print(
                  "❌❌sentence.dart > ERROR: Missing backward space of the word in : ${splittedMutuableLine[i]} ❌❌");
              break;
            }
          } else if (splittedMutuableLine[i].contains("*")) {
            if (kDebugMode) {
              print("❌❌sentence.dart > ERROR: Untagged Astrix(*) found ❌❌");
              break;
            }
          } else {
            //!  ----v3 working----------
            sentenceAllPartsInOrder.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Word(text: splittedMutuableLine[i]),
              ),
            );
            //For adding space
            sentenceAllPartsInOrder.add(
              const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Word(text: " "),
              ),
            );
            //!  ------------------------
          }

          print("index=$i is a word");
        }
      }
    }

    //!  call declared function - 1
    extractTaggedParts();
    //!  call declared function - 2
    extractAllParts();

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text.rich(
        TextSpan(
          children: sentenceAllPartsInOrder,
        ),
      ),
    );
  }
}
