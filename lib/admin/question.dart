import 'package:model/admin/lines/image.dart';
import 'package:model/admin/lines/multique.dart';
import 'package:model/admin/lines/sentence.dart';
import 'package:model/admin/lines/sub.dart';





class AdminQuestion {
  final String question;

  AdminQuestion({required this.question});

  factory AdminQuestion.fromString(String question) {
    return AdminQuestion(question: question);
  }

  /*
  {
    "type": "question",
    "question-numbers": [  //! For AppBar
      12,
      13,
      14
    ],

    "lines": [
      {
        "type": "sentence",
        "content": [
          {
            "type": "word",
            "content": "This is a word"
          },
          {
            "type": "math",
            "content": "\frac4"
          }
        ]
      },
      {
        "type": "image"
        "content": {
          "url": "https:\ww.........",
          "width": 200,
          "height": 200
        }
      },
      {
        "type": "multi-question",
        "content": "12"
      }
      
    ]
  }
  */
  Map<String, dynamic> toJson() {
    //!must be a callable
    //String completeQuestion = getReloadingString();

    List<String> lineList =
        convertStringToListOfLines(question: question);

    List<Map<String, dynamic>> questionAsList = lineToModel(lineList);
    return {
      "type": "question",
      "question-numbers": [
        //! For AppBar
        12,
        13,
        14
      ],
      "lines": questionAsList
    };
  }

  List<String> convertStringToListOfLines({required String question}) {
    int startIndex = 0;
    int endIndex = 0;
    List<String> linesList = [];
    while (true) {
      //print(completeQuestion.indexOf("\n", startIndex));
      endIndex = question.indexOf("\n", startIndex);
      if (endIndex != -1) {
        String line = question.substring(startIndex, endIndex);
        //!This must needed for empty line
        if (line == "") {
          linesList.add(" ");
        } else {
          linesList.add(line);
        }

        startIndex = endIndex + 1;
      } else {
        break;
      }
    }
    return linesList;
  }

  List<Map<String, dynamic>> lineToModel(List<String> lineList) {
    List<Map<String, dynamic>> parsedCompleteQuestion = [];

    for (int i = 0; i < lineList.length; i++) {
      if (lineList[i].startsWith("->Img") || lineList[i].startsWith("->img")) {
        //call Img parser
        parsedCompleteQuestion.add(AdminImage.fromString(lineList[i]).toJson());
      } else if (lineList[i].startsWith("->sub") ||
          lineList[i].startsWith("->sub")) {
        //call SubPart parser
        parsedCompleteQuestion.add(AdminSub.fromString(lineList[i]).toJson());
      } else if (lineList[i].startsWith("->q") ||
          lineList[i].startsWith("->question")) {
        //call Question parser
        parsedCompleteQuestion
            .add(AdminMultiQue.fromString(lineList[i]).toJson());
      } else {
        //call Sentence parser
        parsedCompleteQuestion
            .add(AdminSentence.fromString(lineList[i]).toJson());
      }
    }

    return parsedCompleteQuestion;
  }
}
