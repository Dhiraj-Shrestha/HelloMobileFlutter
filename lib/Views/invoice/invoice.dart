import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/cart/emptyCart.dart';
import 'package:hello_mobiles/Views/invoice/orderItemBody.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/richText.dart';
import 'package:hello_mobiles/utils/constant.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultappbar(context: context, titleText: 'Invoice'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FutureBuilder(
                future: getInvoiceData(),
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.data.length == 0) {
                    return EmptyCart();
                  }
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListView.builder(
                          // physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var mydata = snapshot.data[index];

                            return Card(
                              shadowColor: appColor,
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      leading: Icon(
                                        Icons.inventory,
                                      ),
                                      title: Text(
                                        'Invoice ID: #' +
                                            mydata['invoice_id'].toString(),
                                      ),
                                      subtitle:
                                          Text(mydata['created_at'].toString()),
                                      trailing: Text('Total: ' +
                                          mydata['total'].toString()),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FutureBuilder(
                                      future: getInvoiceDetails(
                                          mydata['invoice_id']),
                                      // initialData: InitialData,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var data = snapshot.data[index];
                                              return Card(
                                                child: OrderItemWidget(
                                                  id: data['invoice_id'],
                                                  productname:
                                                      data['product_name'],
                                                  productquantity:
                                                      data['quantity'],
                                                  sp: data['price'],
                                                  productimage:
                                                      data['product_image'],
                                                  createdat: data['created_at'],
                                                ),
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Cannot load at this time');
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        richText(
                                            simpleText: 'Transaction type',
                                            colorText:
                                                mydata['transaction_type'] == 1
                                                    ? 'Esewa'
                                                    : 'Cash on Delivery'),
                                        richText(
                                            simpleText: 'Transaction Status',
                                            colorText:
                                                mydata['transaction_status'] ==
                                                        1
                                                    ? 'Paid'
                                                    : 'Pending'),
                                        richText(
                                            simpleText: 'Delivery Status',
                                            colorText: mydata['status'] == 1
                                                ? 'Delivered'
                                                : 'Pending'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
        ));
  }

  Future getInvoiceData() async {
    try {
      var response = await Api().getData('invoice');
      var invoice = json.decode(response.body)['data'];
      print(invoice);
      return invoice;
    } on SocketException {
      return null;
    }
  }

  Future getInvoiceDetails(int id) async {
    try {
      var response = await Api().getData('invoiceDetails/$id');
      var invoice = json.decode(response.body)['data'];
      print(invoice);
      // var data = json.decode(invoice);

      return invoice;
    } on SocketException {
      return null;
    }
  }
}
