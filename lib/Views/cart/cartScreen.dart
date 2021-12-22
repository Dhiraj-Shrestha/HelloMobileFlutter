import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'CheckOut.dart';
import 'package:provider/provider.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/Views/cart/emptyCart.dart';
import 'cartItemBody.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var providerData = Provider.of<ProductData>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Colors.white,
            title: ListTile(
              title: Text('Cart'),
              subtitle:
                  Text('Total Item: ' + providerData.totalItems.toString()),
            )),
        body: SingleChildScrollView(
          child: providerData.product.length <= 0
              ? EmptyCart()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: providerData.product.length,
                  itemBuilder: (context, index) {
                    var mydata = providerData.product[index];

                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 120,
                        child: ItemCardBody(
                            context: context,
                            id: mydata.id,
                            itemName: mydata.name,
                            price: mydata.sellingPrice,
                            image: mydata.image,
                            quantity: mydata.quantity),
                      ),
                    );
                  }),
        ),
        bottomSheet: providerData.product.length <= 0
            ? Container(
                child: Text(""),
              )
            : CheckOut());
  }
}
