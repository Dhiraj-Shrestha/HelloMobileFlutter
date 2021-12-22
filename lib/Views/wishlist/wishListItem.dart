import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/products/productdetails/ProductDetails.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:provider/provider.dart';

class WishListItemBody extends StatefulWidget {
  final alldata;

  const WishListItemBody({Key key, this.alldata}) : super(key: key);

  @override
  _WishListItemBodyState createState() => _WishListItemBodyState();
}

class _WishListItemBodyState extends State<WishListItemBody> {
  Future deleteWishlist(int wishlistId) async {
    try {
      var response = await Api().deleteData("wishlist/$wishlistId");
      var products = json.decode(response.body)['data'];
      return products;
    } on SocketException {
      return null;
    }
  }

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.alldata['id'].toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteWishlist(widget.alldata['wishListId']);
        // Provider.of<ProductData>(context).removeProduct(id);
        //
        showSimpleSnackBar(
          context: context,
          title: "${widget.alldata['name']} deleted from wishlist",
        );
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Spacer(),
            Icon(
              FontAwesome.trash,
              color: appColor,
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 2.0, left: 5.0, bottom: 2.0, right: 1.0),
            height: 180,
            child: Card(
              elevation: 1.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                              mydata: widget.alldata,
                            )),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: 130,
                      width: 135,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(widget.alldata['featureImage']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 10.0, bottom: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              text: widget.alldata['name'],
                            ),
                          ),
                          SizedBox(
                            height: 5,
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
                                    text: widget.alldata['price'].toString() +
                                        '  ',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xFF6c63ff),
                                    )),
                                TextSpan(
                                    text: widget.alldata['sellingPrice']
                                        .toString(),
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: appColor,
                                    )),
                              ],
                            ),
                          ),
                          richText(
                              simpleText: 'Product Status',
                              colorText: widget.alldata["availableStatus"] == 1
                                  ? 'On Stock '
                                  : 'Out of Stock'),
                          SizedBox(
                            height: 8,
                          ),
                          widget.alldata["availableStatus"] == 1
                              ? OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: appColor,
                                  ),
                                  label: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    Provider.of<ProductData>(context)
                                        .addProduct(
                                      id: widget.alldata["id"].toString(),
                                      name: widget.alldata["name"],
                                      price: widget.alldata["price"],
                                      quantity: numOfItems,
                                      // discount: widget.mydata['discount'],
                                      image: widget.alldata['featureImage'],
                                      sellingPrice:
                                          widget.alldata["sellingPrice"],
                                    );
                                    showSimpleSnackBar(
                                      context: context,
                                      title:
                                          "${widget.alldata['name']} Added to  Cart",
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2.0, color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
