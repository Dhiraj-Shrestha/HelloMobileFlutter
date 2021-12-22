import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

Widget defaultappbar({BuildContext context, String titleText}) {
  return AppBar(
    elevation: 0.1,
    backgroundColor: Colors.white,
    title: Text(
      titleText,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: appColor,
      ),
    ),
  );
}
