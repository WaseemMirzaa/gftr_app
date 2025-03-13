import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget customText(String text, Color color, double fontSize,
    FontWeight fontWeight, String fontFamily,
    {int maxLines = 1,
    FontStyle? fontStyle,
    bool isTextAlign = false,
    bool overflowText = false,
    bool isTextUnderline = false}) {
  return AutoSizeText(
    text,
    style: TextStyle(
      overflow: overflowText == true ? TextOverflow.ellipsis : null,
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: isTextUnderline ? TextDecoration.underline : null,
    ),
    textAlign: isTextAlign ? TextAlign.center : null,
  );
}
