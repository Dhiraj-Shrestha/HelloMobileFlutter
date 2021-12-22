import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/products/productdetails/ProductDetails.dart';
import 'package:hello_mobiles/Widgets/richText.dart';

class SearchItem extends StatefulWidget {
  final query;

  SearchItem({this.query});
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  //Get Products data
  Future getProductsData(String query) async {
    var response = await Api().getData('searchProduct?name=$query');
    var products = json.decode(response.body)['data'];
    print('==============================================================');
    // print(products);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductsData(widget.query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var mydata = snapshot.data[index];
                return ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                  mydata: mydata,
                                )),
                      );
                      // this.query = mydata['name'].toString();
                      // showResults(context);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(mydata["featureImage"]),
                    ),
                    // Image.network(mydata["featureImage"]),
                    title: Text(mydata['name'].toString()),
                    subtitle: richText(
                        simpleText: 'Rs',
                        colorText: mydata['sellingPrice'].toString()));
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }
}
