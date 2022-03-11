import 'package:flutter/material.dart';
import 'package:model/admin/lines/lines.dart';

class AdminSentence extends Lines{
  @override
  final String subString;

  AdminSentence({required this.subString});


  factory AdminSentence.fromString(String subString) {
    return AdminSentence(subString: subString);
  }


  /*
  {
    "type": "sentence",
    "content": [
      {
        "type": "bold",
        "content": "Bold text"
      },
      {
        "type": "word",
        "content": "This is a word"
      }
    ]
  }
  */
  Map<String, dynamic> toJson() {
    //!  common variables
    String mutableLine = subString;
    List<Map<String, dynamic>> taggedParts = [];
    List<Map<String, dynamic>> sentenceAllPartsInOrder = []; //taggedParts + wordParts

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
              {
                "type": "math",
                "content": subString
              }
            );
            //!--------------------
          } else {
            throw  ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR(math tag): Unclosed or closed with diffrent tag found \n⚠️  ⚠️  ⚠️");
          }
        } else if (subString[startIndex + 1] == "c") {
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
              {
                "type": "code",
                "content": subString
              }
            );
            //!--------------------
          } else {
            throw  ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR(code tag): Unclosed or closed with diffrent tag found \n⚠️  ⚠️  ⚠️");
          }
        } else if (subString[startIndex + 1] == "b") {
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
              {
                "type": "bold",
                "content": subString
              }
            );
            //!--------------------
          } else {
             throw ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR(bold tag): Unclosed or closed with diffrent tag found \n⚠️  ⚠️  ⚠️");
          }
        } else {
           throw ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR: Untagged Astrix(*) found \n⚠️  ⚠️  ⚠️");
        }
        //print("mutableLine after extractTaggedParts method: $mutableLine");
      }
    }

    //!  closure function - 2 declaration
    //declaration
    void extractAllParts() {
      int countForTaggedPartList = 0;
      List<String> splittedMutuableLine = mutableLine.split(" ");
      //print("splittedMutuableLine:  $splittedMutuableLine");

      for (int i = 0; i < splittedMutuableLine.length; i++) {
        //print("splitttedPart index: $i  =${splittedMutuableLine[i]}");
        //!  ⚠️isEmpty is must ⚠️
        if (splittedMutuableLine[i].isEmpty) {
          //!  ----v3 working----------
          sentenceAllPartsInOrder.add(
            {
              "type": "word",
              "content": " "
            }
          );
          //!  ------------------------
          //print("index=$i isEmpty true");
        } else if (splittedMutuableLine[i][0] == "^") {
          //!  Below if condtion is Use for avoiding this -> "^^^^^^^^^^^^XXX" error.
          //?  ERROR: Missing forward space between tag and word
          for (int c = 0; c < splittedMutuableLine[i].length; c++) {
            if (splittedMutuableLine[i][c] != "^") {
              throw ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR: Missing forward space of the word in : ${splittedMutuableLine[i]} \n⚠️  ⚠️  ⚠️");
            }
          }
          //!  ----v3 working----------
          sentenceAllPartsInOrder.add(taggedParts[countForTaggedPartList]);
          countForTaggedPartList++;
          //For adding space
          sentenceAllPartsInOrder.add(
            {
              "type": "word",
              "content": " "
            }
          );
          //!  ------------------------
        } else {
          //!  Below if condtion is Use for avoiding this -> "XXX^^^^^^^^^^^^" error.
          //?  ERROR: Missing backward space between tag and word
          if (splittedMutuableLine[i].contains("^")) {
            throw ErrorDescription("⚠️  ⚠️  ⚠️\nsentence.dart > ERROR: Missing backward space of the word in : ${splittedMutuableLine[i]} \n⚠️  ⚠️  ⚠️");
          } else {
            //!  ----v3 working----------
            sentenceAllPartsInOrder.add(
              {
                "type": "word",
                "content": splittedMutuableLine[i]
              }
            );
            //For adding space
            sentenceAllPartsInOrder.add(
              {
                "type": "word",
                "content": " "
              }
            );
            //!  ------------------------
          }
        }
      }
    }

    //!  call declared function - 1
    extractTaggedParts();
    //!  call declared function - 2
    extractAllParts();

    return {
      "type": "sentence",
      "content": sentenceAllPartsInOrder
    };
  }
}