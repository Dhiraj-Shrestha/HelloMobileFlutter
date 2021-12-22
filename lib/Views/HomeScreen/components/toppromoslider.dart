import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:medicalpasal/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/size/size_config.dart';
// import 'package:medicalpasal/userScreens/api/api.dart';

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  var imagelist = [];

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
  void initState() {
    super.initState();
    getSlider();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder(
        future: getSlider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index, itemIndex) {
                  return Image.network(
                    snapshot.data[index]['image'],
                    fit: BoxFit.fitWidth,
                  );
                },
                options: CarouselOptions(
                  height: getProportionateScreenWidth(200),
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ));
          } else if (snapshot.hasError) {
            return Text('Cannot load at this time');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
