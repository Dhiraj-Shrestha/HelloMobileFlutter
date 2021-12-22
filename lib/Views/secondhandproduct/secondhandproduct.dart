import 'dart:convert';
import 'dart:io';
import 'package:hello_mobiles/Views/secondhandproduct/secondhandproductdetail.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';

class SecondHandProduct extends StatefulWidget {
  @override
  _SecondHandProductState createState() => _SecondHandProductState();
}

class _SecondHandProductState extends State<SecondHandProduct> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            controller: searchController,
            onChanged: onItemChanged,
            decoration: InputDecoration(
              hintText: "Search Products",
              hintStyle: new TextStyle(color: Colors.grey[500]),
            ),
            // textAlign: TextAlign.center,
          ),
        ),
        body: FutureBuilder(
          future: query == ''
              ? getSecondHandDetails()
              : getSecondHandSearchDetails(searchController.text),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                    child: Text(
                  "No prodcuct available",
                  style:
                      TextStyle(color: appColor, fontWeight: FontWeight.bold),
                ));
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var mydata = snapshot.data[index];
                      final datedata = mydata['addedDate'];
                      DateTime dateTime = DateTime.parse(datedata);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondHandProductDetai(
                                      mydata: mydata,
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 2.0,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 120,
                                  width: 150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mydata['detailImages'].length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 100,
                                          width: 150,
                                          padding: const EdgeInsets.only(
                                              top: 1.0,
                                              left: 10.0,
                                              bottom: 5.0,
                                              right: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  secondHandImageSource +
                                                      mydata['detailImages']
                                                          [index]['name']),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 10.0,
                                    bottom: 10.0,
                                    right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mydata['name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    richText(
                                        simpleText: 'Rs',
                                        colorText: mydata['price'].toString()),
                                    richText(
                                        simpleText: 'Available in',
                                        colorText: mydata['city'].toString()),
                                    richText(
                                        simpleText: 'By',
                                        colorText: mydata['username']),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      text: TextSpan(
                                        text:
                                            timeago.format(dateTime).toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    richText(
                                        simpleText: 'Expire Date',
                                        colorText: mydata['expireDate']),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: StrutStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            text: mydata["email"]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            } else if (snapshot.hasError) {
              return Text('Cannot load at this time');
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  String query = '';

  Future getSecondHandDetails() async {
    try {
      var response = await Api().getData('secondhandproducts');
      var secondHand = json.decode(response.body)['data'];
      print('THis is the secondhandproducts');
      print(secondHand);
      return secondHand;
    } on SocketException {
      return null;
    }
  }

  Future getSecondHandSearchDetails(String query) async {
    var response = await Api().getData('searchSecondHandProduct?name=$query');
    var products = json.decode(response.body)['data'];
    // print(products);
    return products;
  }

  onItemChanged(String value) {
    setState(() {
      query = searchController.text;
    });
  }
}
