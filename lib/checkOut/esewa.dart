import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/provider/product.dart';

import 'package:provider/provider.dart';

class EsewaPay extends StatefulWidget {
  final totalPaidPrice;

  const EsewaPay({Key key, this.totalPaidPrice}) : super(key: key);
  @override
  _EsewaPayState createState() => _EsewaPayState();
}

class _EsewaPayState extends State<EsewaPay> {
  ESewaPnp _esewaPnp;
  ESewaConfiguration _configuration;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _configuration = ESewaConfiguration(
      clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
      secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
      environment: ESewaConfiguration.ENVIRONMENT_TEST,
    );
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESewa PNP"),
        backgroundColor: Color.fromRGBO(65, 161, 36, 1),
        elevation: 0,
        excludeHeaderSemantics: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: InputDecoration(
                labelText: widget.totalPaidPrice.toString(),
              ),
            ),
            // Text.rich(
            //   TextSpan(
            //     text: "Total:\n",
            //     children: [
            //       TextSpan(
            //         text: "\Rs:",
            //         style: TextStyle(fontSize: 16, color: Colors.red),

            //       ),
            //       TextSpan(
            //         text: providerData.totalAmount.toString(),
            //         style: TextStyle(fontSize: 16, color: Colors.black),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                elevation: 0,
                color: Color.fromRGBO(65, 161, 36, 1),
                onPressed: () {
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
            SizedBox(
              height: 84,
            ),
            Text(
              "Plugin developed by .",
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pay() async {
    ESewaPayment eSewaPayment = ESewaPayment(
      amount: widget.totalPaidPrice,
      productName: "Test Product",
      productID: "abc123001",
      callBackURL: "https://www.uashim.com.np/",
    );
    try {
      final res = await _esewaPnp.initPayment(payment: eSewaPayment);
      print(res.toString());
      _scaffoldKey.currentState.showSnackBar(
          _buildSnackBar(Color.fromRGBO(65, 161, 36, 1), res.message));
    } on ESewaPaymentException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(_buildSnackBar(Colors.red, e.message));
    }
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}
