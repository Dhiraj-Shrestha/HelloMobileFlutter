import 'package:flutter/material.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset(
              'assets/images/emptyShoppingCart.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            "Opps! Your cart is empty!!",
            style: subHeadingStyle,
          )
        ],
      ),
    );
  }
}
