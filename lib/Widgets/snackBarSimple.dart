import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

void showSimpleSnackBar({context, String title, String message}) {
  Flushbar(
    // aroundPadding: EdgeInsets.all(10),
    borderRadius: 8,
    duration: Duration(seconds: 2),
    backgroundGradient: LinearGradient(
      colors: [appColor.shade800, appColor.shade800],
      stops: [0.2, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 2,
      ),
    ],
    // All of the previous Flushbars could be dismissed by swiping down
    // now we want to swipe to the sides
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,

    message: message ?? '- Hello Mobiles',
  )..show(context);
  // final snackBar = SnackBar(
  //   backgroundColor: Colors.white70,
  //   content: Text(
  //     value,
  //     style: TextStyle(color: appColor),
  //   ),
  //   action: SnackBarAction(
  //     label: 'Ok',
  //     onPressed: () {},
  //   ),
  // );
  // Scaffold.of(context).showSnackBar(snackBar);

  //   SnackBar(
  //   backgroundColor: appColor,
  //   duration: Duration(seconds: 1),
  //   content: new Text(value),
  // ));
}
