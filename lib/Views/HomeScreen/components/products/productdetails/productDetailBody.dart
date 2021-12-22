import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/review/review.dart';
import 'package:hello_mobiles/Widgets/richText.dart';

import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class ProductDetailBody extends StatefulWidget {
  final mydata;

  const ProductDetailBody({Key key, this.mydata}) : super(key: key);

  @override
  _ProductDetailBodyState createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.mydata['name'],
                style: Theme.of(context).textTheme.headline6,
              ),
              FutureBuilder(
                future: getWishlist(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                      onDoubleTap: () {
                        print("taped");
                        return null;
                      },
                      child: InkWell(
                        onTap: () async {
                          if (snapshot.data.length == 0) {
                            favourite = false;
                            if (favourite == false) {
                              //insert code
                              Map data = {
                                'product_id': widget.mydata['id'],
                                'flags': 1,
                              };
                              var response =
                                  await Api().postData(data, 'wishlist');
                              print(response.statusCode);
                              favourite = true;
                              showSimpleSnackBar(
                                context: context,
                                title:
                                    '${widget.mydata['name']} added to wishlist',
                              );

                              setState(() {});

                              print(favourite);
                            }
                          } else if (snapshot.data.length >= 1) {
                            favourite = true;
                            if (favourite == true) {
                              print(snapshot.data[0]);
                              deleteWishlist(snapshot.data[0]['wishListId']);
                              favourite = false;
                              setState(() {});
                              showSimpleSnackBar(
                                context: context,
                                title:
                                    '${widget.mydata['name']} deleted from wishlist',
                              );

                              print(favourite);
                            }
                          }
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(15)),
                            width: getProportionateScreenWidth(64),
                            decoration: BoxDecoration(
                              color:
                                  favourite == true || snapshot.data.length == 1
                                      ? Color(0xFFFFE6E6)
                                      : Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/Heart Icon_2.svg",
                              color:
                                  favourite == true || snapshot.data.length == 1
                                      ? Color(0xFFFF4848)
                                      : Color(0xFFDBDEE4),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Rs: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )),
                TextSpan(
                  text: widget.mydata['discount'].toString() != '0'
                      ? widget.mydata["price"].toString() + '  '
                      : '',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF6c63ff),
                  ),
                ),
                TextSpan(
                    text: widget.mydata["sellingPrice"].toString(),
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: appColor,
                    )),
              ],
            ),
          ),
        ),
        DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                labelStyle: TextStyle(
                    //up to your taste
                    fontWeight: FontWeight.w700),
                indicatorSize: TabBarIndicatorSize.label, //makes it better
                labelColor: appColor, //Google's sweet blue
                unselectedLabelColor: Color(0xff5f6368), //niceish grey
                isScrollable: false, //up to your taste
                indicator: MD2Indicator(
                    //it begins here
                    indicatorHeight: 2,
                    indicatorColor: appColor,
                    indicatorSize: MD2IndicatorSize
                        .normal //3 different modes tiny-normal-full
                    ),
                tabs: <Widget>[
                  Tab(
                    text: "Details",
                  ),
                  Tab(text: "Reviews (${widget.mydata['reviewCount']})"),
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 7),
                color: Color(0xFFf6f6f6),
                height: MediaQuery.of(context).size.height / 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: richText(
                                  simpleText: 'Category',
                                  colorText: widget.mydata['category']),
                            ),
                            richText(simpleText: 'Description', colorText: ''),
                            Text(
                              widget.mydata['description'],
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: ReviewPage(
                          mydata: widget.mydata,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool favourite;

  Future getWishlist() async {
    try {
      var response = await Api().getData("wishlist/${widget.mydata['id']}");
      var products = json.decode(response.body)['data'];
      return products;
    } on SocketException {
      return null;
    }
  }

  int wishListId;

  Future deleteWishlist(int wishlistId) async {
    try {
      var response = await Api().deleteData("wishlist/${wishlistId}");
      var products = json.decode(response.body)['data'];
      return products;
    } on SocketException {
      return null;
    }
  }
}
