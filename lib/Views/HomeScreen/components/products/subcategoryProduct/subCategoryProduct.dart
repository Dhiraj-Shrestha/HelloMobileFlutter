import 'package:flutter/material.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/products/productdetails/ProductDetails.dart';
import 'package:hello_mobiles/checkOut/CheckOut.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';

class SubCategoryProduct extends StatelessWidget {
  final mydata;

  const SubCategoryProduct({Key key, this.mydata}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 2.0, left: 3.0, bottom: 5.0, right: 3.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      mydata: mydata,
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFf6f6f6),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Container(
                // width: 180.0,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          // height: MediaQuery.of(context).size.height / 6,
                          // width: 200.0,
                          child: Hero(
                            tag: 'hero-tag-product${mydata['id']}',
                            child: new DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(2.0)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(mydata['featureImage']),
                                      fit: BoxFit.fitHeight)),
                              child: Container(
                                margin: EdgeInsets.only(top: 150.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: <Color>[
                                        new Color(0x00FFFFFF),
                                        new Color(0xFFFFFFFF),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(0.0, 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        mydata['discount'].toString() != '0'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 25.5,
                                    width: 85.0,
                                    decoration: BoxDecoration(
                                        color: appColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(50),
                                            topLeft: Radius.circular(50))),
                                    child: Center(
                                        child: Text(
                                      mydata['discount'].toString() + '% off',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                ],
                              )
                            : SizedBox()
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top:
                                // top: getProportionateScreenHeight(
                                7.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mydata['name'],
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                letterSpacing: 0.5,
                                color: Colors.black54,
                                fontFamily: "Sans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
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
                                    )),
                                TextSpan(
                                  text: mydata["sellingPrice"].toString(),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: appColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
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
                                          builder: (context) => CheckOutPage(
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
                                                'price': mydata["sellingPrice"],
                                              },
                                            ],
                                            totalPaidPrice:
                                                mydata["sellingPrice"],
                                          ),
                                        ),
                                      );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(color: appColor),
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
