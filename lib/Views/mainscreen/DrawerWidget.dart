import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Views/secondhandproduct/secondhandproductdetail.dart';
import 'package:hello_mobiles/Views/wishlist/wishlist.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/size/size_config.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pushNamed(context, notificationRoute);
                // Navigator.pushNamed(context, shopLocationRoute);
              },
            ),
            _createDrawerItem(
              icon: FontAwesomeIcons.magento,
              text: 'Market Place',
              onTap: () {
                Navigator.pushNamed(context, secondHandProductRoute);
              },
            ),
            _createDrawerItem(
              icon: Icons.favorite_border,
              text: 'Wish List',
              onTap: () {
                Navigator.pushNamed(context, wishListRoute);
              },
            ),
            _createDrawerItem(
              icon: Icons.notifications,
              text: 'Notifications',
              onTap: () {
                Navigator.pushNamed(context, notificationRoute);
              },
            ),
            _createDrawerItem(
              icon: Icons.call,
              text: 'Contact Us',
              onTap: () {
                Navigator.pushNamed(context, socialSiteAdminRoute);
              },
            ),
            _createDrawerItem(
              icon: FontAwesomeIcons.star,
              text: 'FAQ',
              onTap: () {
                Navigator.pushNamed(context, faqRoute);
              },
            ),
            _createDrawerItem(
              icon: FontAwesomeIcons.user,
              text: 'About Us',
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
            ),
            _createDrawerItem(
              icon: Icons.map,
              text: 'Map',
              onTap: () {
                Navigator.pushNamed(context, shopLocationRoute);
                // Navigator.pushNamed(context, shopLocationRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerHeader() {
  return DrawerHeader(
      // margin: EdgeInsets.zero,
      // padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
    Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: getProportionateScreenWidth(150),
          height: getProportionateScreenHeight(25),
        ),
      ),
    ),
    Positioned(
      bottom: 12.0,
      left: 20.0,
      child: Text(
        "Developed for learing purpose by 'Dhiraj'",
        style: TextStyle(
            color: Color(0xFF545454),
            fontSize: 10.0,
            fontWeight: FontWeight.w500),
      ),
    ),
  ]));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Color(0xFF808080),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
