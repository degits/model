import 'package:model/admin/lines/lines.dart';

class AdminMultiQue extends Lines {
  @override
  final String subString;

  AdminMultiQue({required this.subString});


  factory AdminMultiQue.fromString(String subString) {
    return AdminMultiQue(subString: subString);
  }


  /*
    "type": "question",
    "content": 12
  */
  Map<String, dynamic> toJson() {
    String content = subString.substring(3, subString.length);
    if (content.isEmpty || content == " ") {
      throw "⚠️⚠️⚠️ multi_que_parser.dart , No question founded";
    }

    //return
    return {
      "type": "question",
      "content": content
    };
  }
}