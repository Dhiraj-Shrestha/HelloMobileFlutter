import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

Widget appbar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 80.0,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    backgroundColor: appColor,
    title: Image.asset(
      "assets/images/logoWhite.png",
      fit: BoxFit.contain,
      width: MediaQuery.of(context).size.width / 1.7,
    ),
  );
}
