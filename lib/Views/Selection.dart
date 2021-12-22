import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/routes/router_constants.dart';

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2.7,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/started.png",
                  fit: BoxFit.scaleDown,
                )),
            Column(
              children: [
                Text(
                  "Let's Get Started",
                  style: headingStyle,
                ),
              ],
            ),
            Column(
              children: [
                ButtonWidget(
                    buttonColor: appColor,
                    textColor: Colors.white,
                    borderColor: appColor,
                    borderRadius: 20.0,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, signInRoute);
                    },
                    buttonName: "Sign In"),
                ButtonWidget(
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: appColor,
                    borderRadius: 20.0,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, signUpRoute);
                    },
                    buttonName: "Sign Up"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
