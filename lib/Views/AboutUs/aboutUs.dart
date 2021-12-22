import 'package:flutter/material.dart';
import 'package:hello_mobiles/Views/AboutUs/components/aboutusdetails.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(titleText: 'About Us', context: context),
      body: AboutUsPage(),
    );
  }
}
