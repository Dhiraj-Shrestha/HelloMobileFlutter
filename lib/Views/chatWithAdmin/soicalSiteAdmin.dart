import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class SoicalSiteAdmin extends StatefulWidget {
  @override
  _SoicalSiteAdminState createState() => _SoicalSiteAdminState();
}

class _SoicalSiteAdminState extends State<SoicalSiteAdmin> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'Contact Us'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, top: 5, bottom: 0, right: 15),
              child: Text(
                'If you have any queries regarding you can contact us through call, message or can chat with us in our facebook page.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: getProportionateScreenWidth(350),
              child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 105,
                      ),
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Call Us",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PaymentDetails()));
                  onPressed: () {
                    customLaunch('tel: +977 9852054600');
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: appColor))),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: getProportionateScreenWidth(350),
              child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 105,
                      ),
                      Icon(
                        FontAwesomeIcons.facebookMessenger,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Chat With Us",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () => setState(() {
                        customLaunch(
                            _launchInBrowser('https://www.m.me/samir8350'));
                      }),
                  color: appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: getProportionateScreenWidth(350),
              child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 105,
                      ),
                      Icon(
                        Icons.message,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Send Sms",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  onPressed: () {
                    customLaunch('sms: +977 9852054600');
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: appColor))),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
