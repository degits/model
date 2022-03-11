import 'package:model/admin/lines/lines.dart';

class AdminImage extends Lines{

  AdminImage({required this.subString});

  @override
  final String subString;

  factory AdminImage.fromString(String subString) {
    return AdminImage(subString: subString);
  }


  /*
  {
    "type": "image"
    "url": "https:/url",
    "width": 200,
    "height": 400
  }
  */
  Map<String, dynamic> toJson() {
    Map<String, dynamic> imgDetails = {};

    //For type
    imgDetails["type"] = "image";
    //For url
    int startIndex = subString.indexOf("<url>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <url> tag not find";
    }
    int endIndex = subString.lastIndexOf("</url>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </url> tag not find";
    }
    imgDetails["url"] = subString.substring(startIndex + 5, endIndex);

    //For width
    startIndex = subString.indexOf("<width>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <width> tag not find";
    }
    endIndex = subString.lastIndexOf("</width>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </width> tag not find";
    }
    imgDetails["width"] = subString.substring(startIndex + 7, endIndex);

    //For height
    startIndex = subString.indexOf("<height>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , <height> tag not find";
    }
    endIndex = subString.lastIndexOf("</height>");
    if (startIndex == -1) {
      throw "⚠️⚠️⚠️ image_parser.dart , </height> tag not find";
    }
    imgDetails["height"] = subString.substring(startIndex + 8, endIndex);

    //return
    return imgDetails;
  }
}