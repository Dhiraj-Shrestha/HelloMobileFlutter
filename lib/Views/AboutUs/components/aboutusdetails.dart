import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 0.3,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 1.0, left: 10.0, bottom: 5.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/helloMobile.jpeg"),
                  Text(
                    '\nHello Mobile Service is an reputed mobile service center located in Itahari. Smartphone, Chargers, Earphone of differetn brands are available at cheap rate. \n Mobile repairing service is also available here, an problem with your smartphone will be solve here. ',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Opening Hours",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                      'Sunday: 7:00 PM – 12:00 AM\nMonday: 7:00 PM – 3:30 AM\nTuesday: 7:00 PM – 3:30 AM\nWednesday: 7:00 PM – 3:30 AM\nThursday: 7:00 PM – 3:30 AM\nFriday: 7:00 PM – 3:30 AM\nSaturday: 7:00 PM – 3:30 AM\nSunday: 7:00 PM – 12:00 AM'),
                  // Spacer(),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: getProportionateScreenWidth(350),
                    child: RaisedButton(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 65,
                            ),
                            Icon(
                              FontAwesomeIcons.facebookSquare,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Join Our Facebook Group",
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
                        onPressed: () => setState(() {
                              customLaunch(_launchInWebViewOrVC(
                                  'https://www.facebook.com/groups/739997822767685'));
                            }),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(color: appColor))),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
