import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_mobiles/utils/constant.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    this.numOfitem = 0,
    @required this.press,
    this.icon,
  }) : super(key: key);

  final int numOfitem;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            // padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: 45,
            // height: getProportionateScreenWidth(46),
            width: 45,

            // decoration: BoxDecoration(
            //   color: appColor.withOpacity(0.0002),
            //   shape: BoxShape.circle,
            // ),
            child: Icon(icon),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 16,
                // height: getProportionateScreenWidth(16),
                width: 16,
                // width: getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: 10,
                      // fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
