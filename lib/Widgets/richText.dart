import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

Widget richText({simpleText, colorText}) {
  return RichText(
    text: TextSpan(children: [
      TextSpan(
          text: simpleText + ': ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
      TextSpan(
          text: colorText,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: appColor,
          )),
    ]),
  );
}
