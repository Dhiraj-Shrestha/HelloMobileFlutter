import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/products/productdetails/ProductDetails.dart';
import 'package:hello_mobiles/checkOut/CheckOut.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';

class ProductCard extends StatelessWidget {
  Future getProductData() async {
    try {
      var response = await Api().getData('recentproducts');
      var products = json.decode(response.body)['data'];

      return products;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getProductData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    ...List.generate(snapshot.data.length, (index) {
                      var mydata = snapshot.data[index];

                      return Container(
                        width: getProportionateScreenWidth(150),
                        height: getProportionateScreenHeight(200),
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.black,
                          color: Color(0xFFf6f6f6),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                              mydata: mydata,
                                            )),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: 'hero-tag-product${mydata['id']}',
                                      child: Image(
                                        image: NetworkImage(
                                            mydata["featureImage"]),
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle: StrutStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                          text: mydata["name"]),
                                    ),
                                  ],
                                ),
                              ),
                              //Text
                              SizedBox(
                                height: 2,
                              ), //SizedBox
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Rs: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        )),
                                    TextSpan(
                                      text: mydata['discount'].toString() != '0'
                                          ? mydata["price"].toString() + '  '
                                          : '',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF6c63ff),
                                      ),
                                    ),
                                    TextSpan(
                                        text: mydata["sellingPrice"].toString(),
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: appColor,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                              SizedBox(
                                width: getProportionateScreenWidth(100),
                                height: getProportionateScreenHeight(30),
                                child: FlatButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: appColor, width: 2),
                                  ),
                                  onPressed: () {
                                    mydata['availableStatus'].toString() == '0'
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                      mydata: mydata,
                                                    )),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckOutPage(
                                                totalAmount: mydata["price"],
                                                totalDiscount: mydata["price"] -
                                                    mydata["sellingPrice"],
                                                totalSp: mydata["sellingPrice"],
                                                orderTotalAmount:
                                                    mydata["sellingPrice"],
                                                productDetails: [
                                                  {
                                                    'product_id': mydata['id'],
                                                    'quantity': 1,
                                                    'price':
                                                        mydata["sellingPrice"],
                                                  },
                                                ],
                                                totalPaidPrice:
                                                    mydata["sellingPrice"],
                                              ),
                                            ),
                                          );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Text(
                                      'Buy Now',
                                      style: TextStyle(color: appColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ), //SizedBox
                            ],
                          ), //Padding
                          //SizedBox
                        ),
                      );
                    }),
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
        ],
      ),
    );
  }
}
