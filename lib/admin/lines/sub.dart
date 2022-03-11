import 'lines.dart';

class AdminSub extends Lines {
  @override
  final String subString;

  AdminSub({required this.subString});


  factory AdminSub.fromString(String subString) {
    return AdminSub(subString: subString);
  }


  /*
    "type": "sub",
    "content": "(a)"
  */
  Map<String, dynamic> toJson() {
    String content = subString.substring(6, subString.length);
    if (content.isEmpty || content == " ") {
      throw "⚠️⚠️⚠️ admin > sub.dart , No question founded";
    }

    //return
    return {
      "type": "sub",
      "content": content
    };
  }
}