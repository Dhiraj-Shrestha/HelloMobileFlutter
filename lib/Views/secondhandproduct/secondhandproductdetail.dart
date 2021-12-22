import 'package:flutter/material.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

/// Detail Product for Recomended Grid in home screen
class SecondHandProductDetai extends StatefulWidget {
  final mydata;
  @override
  const SecondHandProductDetai({Key key, this.mydata}) : super(key: key);

  @override
  _SecondHandProductDetaiState createState() => _SecondHandProductDetaiState();
}

class _SecondHandProductDetaiState extends State<SecondHandProductDetai> {
  Widget build(BuildContext context) {
    String memberSince = convertDateTimeDisplay(widget.mydata['memberSince']);
    return Scaffold(
      key: _key,
      appBar: defaultappbar(context: context, titleText: 'Second hand product'),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider

                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.height / 3.7,
                              child: PhotoViewGallery.builder(
                                scrollPhysics: const BouncingScrollPhysics(),
                                builder: (BuildContext context, int index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider: NetworkImage(
                                      secondHandImageSource +
                                          widget.mydata['detailImages'][index]
                                              ['name'],
                                    ),
                                    initialScale:
                                        PhotoViewComputedScale.contained * 1.5,
                                  );
                                },
                                itemCount: widget.mydata['detailImages'].length,
                                loadingBuilder: (context, event) => Center(
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      value: event == null
                                          ? 0
                                          : event.cumulativeBytesLoaded /
                                              event.expectedTotalBytes,
                                    ),
                                  ),
                                ),
                                loadFailedChild: Text("Cound not load"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.mydata['name'],
                            style: headingStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          richText(
                              simpleText: 'Rs',
                              colorText: widget.mydata['price'].toString()),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: richText(
                                simpleText: 'Warrenty Available',
                                colorText: widget.mydata['warrenty'] == 1
                                    ? 'yes'
                                    : 'No'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: richText(
                                simpleText: 'Expire Date',
                                colorText: widget.mydata['expireDate']),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      // height: 205.0,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                "Description" + '',
                              ),
                            ),
                            Divider(
                              color: Colors.black12,
                              height: 1.0,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Text(
                                "- " + widget.mydata['description'],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for seller details
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Seller Details",
                            ),
                            Divider(
                              color: Colors.black12,
                              height: 1.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 10.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: richText(
                                        simpleText: 'Name',
                                        colorText: widget.mydata['username']),
                                  ),
                                  widget.mydata['showDetail'] == 1
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: richText(
                                                  simpleText: 'Address',
                                                  colorText: widget
                                                          .mydata['city'] +
                                                      ', ' +
                                                      widget.mydata['area']),
                                            ),
                                            richText(
                                                simpleText: 'Member Since',
                                                colorText: memberSince),
                                            SizedBox(
                                              height: 30.0,
                                              child: Row(
                                                // crossAxisAlignment:
                                                // CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  richText(
                                                      simpleText:
                                                          'Contact Number',
                                                      colorText: widget
                                                          .mydata['phoneNumber']
                                                          .toString()),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.call,
                                                        color: appColor,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        customLaunch(
                                                            'tel: +977 ${widget.mydata['phoneNumber']}');
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        richText(
                                            simpleText: 'Email',
                                            colorText: widget.mydata['email']
                                                .toString()),
                                        IconButton(
                                            icon: Icon(
                                              Icons.mail,
                                              color: appColor,
                                              size: 20,
                                            ),
                                            onPressed: _launchEmail),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for terms and condition
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: appColor,
                                  size: 17.0,
                                ),
                                Text(
                                  " Be safe, Beware of fraud scams",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black12,
                              height: 1.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 10.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              'Hello mobile is NOT involved in transaction of any goods/services in the secondhand market. It is only platform to share information. You are directly contacting the person who has posted the advertisement and you agree not to hold HelloMobiles responsible for their act in any circumstances. We strongly encourage you to take necessary precaution. Avoid advance payment, check goods before purchasing, instead of cash use mobile wallets (IME Pay, Esewa, Khalti, Connect Ips, etc) or bank transfer for payments.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          )),
                                      TextSpan(
                                          text: 'Terms and Condition',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: appColor,
                                          )),
                                    ]),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 20.0)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateTime displayDate = DateTime.parse(date);
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final String formatted = serverFormater.format(displayDate);
    return formatted.toString();
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: widget.mydata['email'],
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  int valueItemChart = 0;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }
}
