import 'package:flutter/material.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';

import 'otp_form.dart';

class OtpCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/otp.png",
                    fit: BoxFit.contain,
                    width: getProportionateScreenWidth(220),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    child: Text(
                  'OTP Verification',
                  style: largeTextStyle,
                )),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text("We sent you code in your mail"),
                buildTimer(),
                OtpForm(),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(
                        decoration: TextDecoration.underline, color: appColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: appColor),
          ),
        ),
      ],
    );
  }
}
