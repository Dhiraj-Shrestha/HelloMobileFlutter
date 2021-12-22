import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/wishlist/wishListItem.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'Wish List'),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 700,
            child: FutureBuilder(
                future: getWishlist(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.length == 0
                        ? NoWishlist()
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var alldata = snapshot.data[index];
                              return WishListItemBody(alldata: alldata);
                            });
                  } else if (snapshot.hasError) {
                    return Text('Cannot load');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
    );
  }

  Future getWishlist() async {
    try {
      var response = await Api().getData('wishlist');
      var products = json.decode(response.body)['data'];
      return products;
    } on SocketException {
      return null;
    }
  }
}

class NoWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
            Image.asset(
              "assets/images/wishlistNotFound.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "No item in wishlist",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
  }
}
