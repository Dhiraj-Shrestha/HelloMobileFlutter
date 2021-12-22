import 'package:flutter/material.dart';

import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/checkOut/CheckOut.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:hello_mobiles/utils/constant.dart';

import 'package:provider/provider.dart';

import 'package:hello_mobiles/size/size_config.dart';

import 'productDetailBody.dart';

import 'ProductDetailImage.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key key, this.mydata}) : super(key: key);

  final mydata;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImage = 0;
  int numOfItems = 1;
  var newList;
  var list1;
  var list2;

  @override
  void initState() {
    super.initState();
    buildSmallProductPreview(context);
  }

  Widget buildSmallProductPreview(BuildContext context) {
    if (widget.mydata["detailImages"].length == 0) {
      list1 = [widget.mydata["featureImage"]];
      setState(() {
        newList = list1;
      });
    } else {
      list1 = [widget.mydata["featureImage"]];
      list2 = [productImageSource + widget.mydata["detailImages"][0]["name"]];
      setState(() {
        list2.clear();
      });
      for (var i = 0; i < widget.mydata["detailImages"].length; i++) {
        list2
            .add(productImageSource + widget.mydata["detailImages"][i]["name"]);
      }

      // list2 = [productImageSource + widget.mydata["detailImages"][0]["name"]];
      setState(() {
        newList = list1 + list2;
      });
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: newList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(8),
                        height: getProportionateScreenWidth(48),
                        width: getProportionateScreenWidth(48),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: appColor
                                  .withOpacity(selectedImage == index ? 1 : 0)),
                        ),
                        child: Image.network(newList[index]),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProductDetailImage(
                tag: 'hero-tag-product${widget.mydata['id']}',
                image: newList[selectedImage],
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
              buildSmallProductPreview(context),
              ProductDetailBody(
                mydata: widget.mydata,
              ),
            ],
          ),
        ),
        bottomSheet: widget.mydata['availableStatus'] == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ButtonWidget(
                        buttonColor: appColor,
                        textColor: Colors.white,
                        borderColor: appColor,
                        borderRadius: 7.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOutPage(
                                totalAmount: widget.mydata["price"],
                                totalDiscount: widget.mydata["price"] -
                                    widget.mydata["sellingPrice"],
                                totalSp: widget.mydata["sellingPrice"],
                                orderTotalAmount: widget.mydata["sellingPrice"],
                                productDetails: [
                                  {
                                    'product_id': widget.mydata['id'],
                                    'quantity': 1,
                                    'price': widget.mydata["sellingPrice"],
                                  },
                                ],
                                totalPaidPrice: widget.mydata["sellingPrice"],
                              ),
                            ),
                          );
                        },
                        buttonName: "Buy Now"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ButtonWidget(
                        buttonColor: appColor,
                        textColor: Colors.white,
                        borderColor: appColor,
                        borderRadius: 10.0,
                        onPressed: () {
                          cartBottomSheet(context);
                        },
                        buttonName: "Add to Cart"),
                  ),
                ],
              )
            : Container(
                color: appColor,
                height: 50,
                child: Center(
                  child: Text(
                    "Sorry this product is currently out of stock",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }

  // Edit Modal
  void cartBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height * .60,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: Image.network(
                                newList[selectedImage],
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.mydata["name"],
                                  style: TextStyle(fontSize: 18),
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
                                        text: widget.mydata['discount']
                                                    .toString() !=
                                                '0'
                                            ? widget.mydata["price"]
                                                    .toString() +
                                                '  '
                                            : '',
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xFF6c63ff),
                                        ),
                                      ),
                                      TextSpan(
                                          text: widget.mydata["sellingPrice"]
                                              .toString(),
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: appColor,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: appColor,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 32,
                          child: buildOutlineButton(
                              press: () {
                                if (numOfItems > 1) {
                                  stateSetter(() {
                                    numOfItems--;
                                  });
                                }
                              },
                              icon: Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            // if our item is less  then 10 then  it shows 01 02 like that
                            numOfItems.toString().padLeft(2, "0"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 32,
                          child: buildOutlineButton(
                              press: () {
                                if (numOfItems >= 5) {
                                  showSimpleSnackBar(
                                    context: context,
                                    title: 'You can only add 5 unit of' +
                                        widget.mydata["name"],
                                  );
                                } else {
                                  stateSetter(() {
                                    numOfItems++;
                                  });
                                }
                              },
                              icon: Icons.add),
                        ),
                      ],
                    ),
                    Spacer(),
                    ButtonWidget(
                      textColor: Colors.white,
                      borderColor: appColor,
                      buttonColor: appColor,
                      borderRadius: 12,
                      buttonName: 'Add to Cart',
                      onPressed: () {
                        Provider.of<ProductData>(context).addProduct(
                          id: widget.mydata["id"].toString(),
                          name: widget.mydata["name"],
                          price: widget.mydata["price"],
                          quantity: numOfItems,
                          // discount: widget.mydata['discount'],
                          image: widget.mydata["featureImage"],
                          sellingPrice: widget.mydata["sellingPrice"],
                        );
                        setState(() {
                          Navigator.of(context).pop();
                        });

                        showSimpleSnackBar(
                          context: context,
                          title: '${widget.mydata['name']} added to cart',
                        );
                      },
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: RaisedButton(
                    //           child: Text("Add To Cart"),
                    //           onPressed: () {
                    //             // if (numOfItems > widget.mydata["quantity"]) {
                    //             //   showInSnackBar(
                    //             //       context,
                    //             //       widget.mydata["name"] +
                    //             //           "is not available at choosen quantity\nQuantity remain:" +
                    //             //           widget.mydata["quantity"].toString());
                    //             // } else {
                    //             Provider.of<ProductData>(context).addProduct(
                    //               id: widget.mydata["id"].toString(),
                    //               name: widget.mydata["name"],
                    //               price: widget.mydata["price"],
                    //               quantity: numOfItems,
                    //               // discount: widget.mydata['discount'],
                    //               image: widget.mydata["featureImage"],
                    //               sellingPrice: widget.mydata["sellingPrice"],
                    //             );
                    //             print(widget.mydata['price']);
                    //             //   print(widget.mydata);
                    //             // }

                    //             // Navigator.push(context,
                    //             //     MaterialPageRoute(builder: (context) => CartPage()));
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  OutlineButton buildOutlineButton({Function press, IconData icon}) {
    return OutlineButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      onPressed: press,
      child: Icon(icon),
    );
  }
}
