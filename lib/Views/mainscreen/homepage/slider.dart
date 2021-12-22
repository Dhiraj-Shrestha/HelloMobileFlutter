import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  //getslider image
  Future getSlider() async {
    try {
      var response = await Api().getData('slider');
      var slider = json.decode(response.body)['data'];

      var sliderImage = slider;
      // print("=======================================================");
      print(sliderImage);
      print("=======================================================");
      return sliderImage;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
