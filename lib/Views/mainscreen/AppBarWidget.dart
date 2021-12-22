import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Views/search/productSearch.dart';
import 'package:hello_mobiles/Widgets/ContainerWithCount.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:provider/provider.dart';

Widget appBarWidget(context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: Colors.white,
    // title: Image.asset(
    //   "assets/images/ic_app_icon.png",
    //   width: 80,
    //   height: 40,
    // ),
    title: Text(
      'Hello Mobiles',
      style: TextStyle(color: appColor),
    ),
    actions: <Widget>[
      IconBtnWithCounter(
        icon: Icons.search,
        press: () {
          // showSearch(context: context, delegate: DataSearch();
        },
      ),
      IconBtnWithCounter(
        numOfitem: Provider.of<ProductData>(context).totalItems,
        icon: Icons.shopping_cart,
        press: () {
          Navigator.pushNamed(context, cartRoute);
        },
      )
    ],
  );
}
