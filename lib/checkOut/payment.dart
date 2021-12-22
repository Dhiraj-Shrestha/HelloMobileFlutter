import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/utils/constant.dart';

class PaymentMethod extends StatefulWidget {
  final totalPaidPrice;
  final productDetails;

  const PaymentMethod({Key key, this.totalPaidPrice, this.productDetails})
      : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultappbar(context: context, titleText: 'Payment'),
        key: _scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Card(
                child: RadioListTile(
                  value: 0,
                  groupValue: selectedRadioTile,
                  title: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        child: Icon(
                          FontAwesomeIcons.moneyBillAlt,
                          size: 18.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("Cash on Delivery"),
                    ],
                  ),
                  onChanged: (val) {
                    setSelectedRadioTile(val);
                  },
                  activeColor: appColor,
                  autofocus: true,
                ),
              ),
            ),
            Card(
              child: RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        'assets/images/eSewa.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Esewa Mobile Wallet")
                  ],
                ),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                  print(selectedRadioTile);
                },
                activeColor: appColor,
              ),
            ),
            Spacer(),
            Container(
              color: Color(0xFFf6f6f6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15.0),
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(color: appColor, fontSize: 20.0),
                        ),
                        Text(
                          'Rs: ' + widget.totalPaidPrice.toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    )),
                  ),
                  ButtonWidget(
                    borderColor: appColor,
                    buttonColor: appColor,
                    textColor: Colors.white,
                    borderRadius: 12.0,
                    buttonName: 'Place Order',
                    onPressed: () async {
                      if (selectedRadioTile == 0) {
                        Map data = {
                          'total': widget.totalPaidPrice,
                          'transaction_type': selectedRadioTile,
                          'products': widget.productDetails,
                        };

                        var response = await Api().postData(data, 'invoice');
                        var result = json.decode(response.body);
                        print(result);
                        if (result['code'] == 200) {
                          showThankYouBottomSheet(context);
                        } else {
                          showSimpleSnackBar(
                              context: context, title: 'some thing went wrong');
                        }
                        print(result);
                      } else if (selectedRadioTile == 1) {
                        _displayTextInputDialog(context);
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  TextEditingController priceController = new TextEditingController();
  int selectedRadioTile;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
    super.initState();
    // selectedRadio = 0;
    selectedRadioTile = 0;
    priceController.text = 'Rs: ' + widget.totalPaidPrice.toString();
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.8,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/thankYou.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, invoiceRoute);
                      },
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "View Order",
                        style:
                            textFormFieldMedium.copyWith(color: Colors.white),
                      ),
                      color: appColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          child: AlertDialog(
            title: Container(
              width: double.infinity,
              height: 50,
              color: Colors.green,
              child: Center(
                  child: Text(
                "Esewa",
                style: TextStyle(color: Colors.white),
              )),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      controller: priceController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Plugin developed by .",
                      style: TextStyle(color: Colors.black45),
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 0,
                        color: Color.fromRGBO(65, 161, 36, 1),
                        onPressed: () async {
                          Map data = {
                            'total': widget.totalPaidPrice,
                            'transaction_type': selectedRadioTile,
                            'transaction_status': 1,
                            'products': widget.productDetails,
                          };

                          var response = await Api().postData(data, 'invoice');
                          var result = json.decode(response.body);
                          print(result);
                          if (result['code'] == 200) {
                            Navigator.pop(context);
                            showThankYouBottomSheet(context);
                          } else {
                            showSimpleSnackBar(
                                context: context,
                                title: 'some thing went wrong');
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CheckoutPage()));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PaymentResult()));
                        },
                        child: Text(
                          "Pay",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
