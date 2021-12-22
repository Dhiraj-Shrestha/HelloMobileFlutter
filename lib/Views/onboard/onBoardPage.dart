import 'package:flutter/material.dart';
import 'package:hello_mobiles/Views/onboard/onBoardDesign.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/utils/constant.dart';

class OnBoardPage extends StatefulWidget {
  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            slideIndex = value;
          });
        },
        itemCount: onBoardData.length,
        itemBuilder: (context, index) => OnBoardDesign(
          image: onBoardData[index]['image'],
          title: onBoardData[index]['title'],
          details: onBoardData[index]['details'],
        ),
      ),
      bottomSheet: slideIndex != onBoardData.length - 1
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      controller.animateToPage(onBoardData.length - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                          color: Color(0xFF0074E4),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print("this is slideIndex: $slideIndex");
                      controller.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: Color(0xFF0074E4),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, mainRoute);
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                color: appColor,
                alignment: Alignment.center,
                child: Text(
                  "Get Started Now",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
    );
  }

  List<Map<String, String>> onBoardData = [
    {
      "image": "assets/images/onBoard1.png",
      "title": "Hello",
      "details":
          "Welcome, explore your journey and  enjoy your online shopping with us.",
    },
    {
      "image": "assets/images/onBoard2.png",
      "title": "Buy and Sell",
      "details":
          "Explore the shop and buy and sell your mobile devices and its part.",
    },
    {
      "image": "assets/images/onBoard3.png",
      "title": "Enjoy With Us",
      "details": "Enjoy dealing with products  ",
    },
  ];

  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: 6.0,
      width: isCurrentPage ? 10.0 : 7.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? appColor : Colors.grey[300],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller = new PageController();
  }
}
