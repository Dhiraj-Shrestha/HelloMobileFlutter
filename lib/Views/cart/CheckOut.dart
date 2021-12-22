import 'package:flutter/material.dart';
import 'package:hello_mobiles/checkOut/CheckOut.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProductData>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(2),
        horizontal: getProportionateScreenWidth(10),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "Total:\n",
                  children: [
                    TextSpan(
                      text: "\Rs:",
                      style: TextStyle(fontSize: 16, color: appColor),
                    ),
                    TextSpan(
                      text: providerData.totalSp.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(190),
                child: ButtonWidget(
                    buttonColor: appColor,
                    textColor: Colors.white,
                    borderColor: appColor,
                    borderRadius: 7.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutPage(
                                  totalAmount: providerData.totalAmount,
                                  totalDiscount: providerData.totalDiscount,
                                  totalSp: providerData.totalSp,
                                  orderTotalAmount: providerData.totalSp,
                                  productDetails: providerData.product.map((e) {
                                    return {
                                      'product_id': e.id,
                                      'quantity': e.quantity,
                                      'price': e.price,
                                    };
                                  }).toList(),
                                  totalPaidPrice: providerData.totalSp,
                                )),
                      );
                    },
                    buttonName: "Check Out"),
              ),
            ],
          ),
        ],
      ),
    );
    // Text(Provider.of<ProductData>(context).totalAmount.toString()),,
  }
}
