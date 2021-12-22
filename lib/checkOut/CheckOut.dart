import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:hello_mobiles/checkOut/payment.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  final totalAmount;
  final totalDiscount;
  final totalSp;
  final orderTotalAmount;
  final productDetails;
  final totalPaidPrice;

  const CheckOutPage({
    Key key,
    this.totalAmount,
    this.totalDiscount,
    this.totalSp,
    this.orderTotalAmount,
    this.productDetails,
    this.totalPaidPrice,
  }) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int selectedRadioTile;
  Future getUserData() async {
    try {
      var response = await Api().getData('user');
      var user = json.decode(response.body);
      return user;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductData providerData = Provider.of<ProductData>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: defaultappbar(titleText: 'Check Out'),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mydata = snapshot.data;
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        // selectedAddressSection(mydata),
                        checkoutItem(mydata: mydata),
                        priceSection(providerData)
                      ],
                    ),
                  ),
                  flex: 90,
                ),
                ButtonWidget(
                  borderColor: appColor,
                  buttonColor: appColor,
                  textColor: Colors.white,
                  borderRadius: 12.0,
                  buttonName: 'Proceed to Pay',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethod(
                                totalPaidPrice: widget.totalPaidPrice,
                                productDetails: widget.productDetails,
                              )),
                    );
                  },
                ),
              ],
            );
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

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: textFormFieldMedium.copyWith(
            fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  checkoutItem({mydata}) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  richText(
                    simpleText: 'Name',
                    colorText: mydata['name'],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  richText(
                    simpleText: 'Address',
                    colorText: mydata['city'] +
                        '-' +
                        mydata['ward'] +
                        ', ' +
                        mydata['area'],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  priceSection(ProductData productData) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: textFormFieldMedium.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total MRP", widget.totalAmount.toString(),
                  Colors.grey.shade700),
              createPriceItem(
                  "Bag discount", widget.totalDiscount.toString(), appColor),
              createPriceItem("Order Total", widget.totalSp.toString(),
                  Colors.grey.shade700),
              createPriceItem("Delievery Charges", "FREE", appColor),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    style: textFormFieldSemiBold.copyWith(
                        color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    widget.orderTotalAmount.toString(),
                    style: textFormFieldMedium.copyWith(
                        color: Colors.black, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: textFormFieldMedium.copyWith(
                color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: textFormFieldMedium.copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
