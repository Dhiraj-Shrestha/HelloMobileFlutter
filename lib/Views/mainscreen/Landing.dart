import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hello_mobiles/Views/HomeScreen/HomePage.dart';
import 'package:hello_mobiles/Views/cart/cartScreen.dart';

import 'package:hello_mobiles/Views/profile/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Views/secondHandSale/secondHandSale.dart';
import 'package:hello_mobiles/Views/wishlist/wishlist.dart';
import 'package:hello_mobiles/utils/constant.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _cIndex = 0;

  final tabs = [
    HomePage(),
    WishlistScreen(),
    SecondHandSale(),
    CartScreen(),
    ProfileScreen(),
    // Center(
    //   child: Text("5"),
    // ),
  ];

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: tabs[_cIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _cIndex,
          selectedIconTheme: IconThemeData(color: appColor, size: 25),
          type: BottomNavigationBarType.fixed,
          iconSize: 20.0,
          // selectedItemColor: Colors.deepPurple,
          // unselectedItemColor: Colors.greenAccent,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.handshake), label: 'Sell'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.shoppingCart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _cIndex = index;
            });
          },
        ),
      ),
    );
  }
}
