// import 'dart:convert';
// import 'dart:io';
// import 'package:hello_mobiles/Api/Api.dart';
// import 'package:hello_mobiles/Views/invoice/orderItemBody.dart';

// import 'package:hello_mobiles/size/size_config.dart';
// import 'package:hello_mobiles/utils/constant.dart';

// import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter/material.dart';

// class OrderDetails extends StatefulWidget {
//   final invoiceid;
//   final username;
//   final city;
//   final area;
//   final ward;
//   final address;
//   final phone;
//   final total;
//   final transactiontype;
//   final transactionstatus;
//   final status;

//   const OrderDetails({
//     Key key,
//     this.invoiceid,
//     this.username,
//     this.city,
//     this.area,
//     this.ward,
//     this.address,
//     this.phone,
//     this.total,
//     this.transactiontype,
//     this.transactionstatus,
//     this.status,
//   }) : super(key: key);

//   @override
//   _OrderDetailsState createState() => _OrderDetailsState();
// }

// class _OrderDetailsState extends State<OrderDetails> {
//   int status;
//   int transactionstatus;
//   void customLaunch(command) async {
//     if (await canLaunch(command)) {
//       await launch(command);
//     } else {
//       print('could not launch $command');
//     }
//   }

//   Future getInvoiceDetails(int id) async {
//     try {
//       var response = await Api().getData('invoiceDetails/$id');
//       var invoice = json.decode(response.body)['data'];
//       print(invoice);
//       // var data = json.decode(invoice);

//       return invoice;
//     } on SocketException {
//       return null;
//     }
//   }

//   // Future save(int id) async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   String token = preferences.getString('token');
//   //   final uri = Uri.parse(apiLink + '/api/invoice/$id?_method=PUT');

//   //   MultipartRequest request = http.MultipartRequest('post', uri);

//   //   request.headers['Accept'] = 'application/json';
//   //   request.headers['Authorization'] = 'Bearer ' + token;
//   //   request.fields['status'] = status.toString();
//   //   request.fields['transaction_status'] = transactionstatus.toString();

//   //   var response = await request.send();
//   //   print(response.statusCode);
//   //   // print(response);

//   //   if (response.statusCode == 200) {
//   //     Get.snackbar(
//   //       "Success",
//   //       "Product Delivered Successfully",
//   //       icon: Icon(Icons.account_circle),
//   //       shouldIconPulse: true,
//   //       barBlur: 20,
//   //       isDismissible: true,
//   //       duration: Duration(seconds: 3),
//   //     );
//   //   } else {
//   //     showSimpleSnackBar(context: context, title: 'Some thing went wrong');
//   //   }
//   //   // String url = baseUrl + endPoint;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     // return Scaffold(drawer: DrawerWidget());
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,

//         centerTitle: true,
//         backgroundColor: Colors.white,
//         // title: Image.asset(
//         //   "assets/images/ic_app_icon.png",
//         //   width: 80,
//         //   height: 40,
//         // ),
//         title: Text(
//           'Medical Pasal',
//           style: TextStyle(color: appColor),
//         ),
//       ),
//       body: Container(
//         // margin: EdgeInsets.only(
//         //     bottom: _con.order.orderStatus.id == '5' ? 147 : 200),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: appColor,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Theme.of(context).focusColor.withOpacity(0.1),
//                         blurRadius: 5,
//                         offset: Offset(0, 2)),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).hintColor.withOpacity(0.1)),
//                       child: Icon(
//                         Icons.blur_on_rounded,
//                         color: Theme.of(context).hintColor.withOpacity(0.8),
//                         size: 30,
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     Flexible(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   // S.of(context).order_id +
//                                   //     "#${_con.order.id}",
//                                   'Invoice ID: #' + widget.invoiceid.toString(),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                   style: Theme.of(context).textTheme.subhead,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 10),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(vertical: 0),
//                   leading: Icon(
//                     Icons.person_pin,
//                     color: Theme.of(context).hintColor,
//                   ),
//                   title: Text(
//                     'Customer',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Name: ' + widget.username),
//                         IconButton(icon: Icon(Icons.person), onPressed: null)
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Address: ' +
//                             widget.city +
//                             ', ' +
//                             widget.area +
//                             ', ' +
//                             widget.ward +
//                             ', ' +
//                             widget.address),
//                         IconButton(
//                             icon: Icon(Icons.location_city), onPressed: null)
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Contact: ' + widget.phone.toString()),
//                         IconButton(
//                             icon: Icon(Icons.call),
//                             onPressed: () {
//                               customLaunch('tel: +977 ${widget.phone}');
//                             })
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 10),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(vertical: 0),
//                   leading: Icon(
//                     Icons.fastfood,
//                     color: Theme.of(context).hintColor,
//                   ),
//                   title: Text(
//                     // S.of(context).foods_ordered,
//                     "Ordered",
//                     style: Theme.of(context).textTheme.headline6,
//                     // style: Theme.of(context).textTheme.display1,
//                   ),
//                 ),
//               ),
//               FutureBuilder(
//                 future: getInvoiceDetails(widget.invoiceid),
//                 // initialData: InitialData,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         var data = snapshot.data[index];
//                         return Card(
//                           child: OrderItemWidget(
//                             id: data['invoice_id'],
//                             productname: data['product_name'],
//                             productquantity: data['quantity'],
//                             sp: data['price'],
//                             productimage: data['product_image'],
//                             createdat: data['created_at'],
//                             // productname=,
//                             //  productquantity,
//                             //  sp=,
//                             //  productimage;
//                             //  createdat;
//                           ),
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('Cannot load at this time');
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: getProportionateScreenHeight(150),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         decoration: BoxDecoration(
//             // color: kPrimaryColor,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20), topLeft: Radius.circular(20)),
//             boxShadow: [
//               BoxShadow(
//                 color: Theme.of(context).focusColor.withOpacity(0.15),
//                 offset: Offset(0, -2),
//               )
//             ]),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width - 40,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   buildBottomRows(
//                       context: context,
//                       title: 'Total: ',
//                       trailing: 'Rs: ' + widget.total),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                       child: FlatButton(
//                     onPressed: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Text('Transaction Status'),
//                               content: Text('Cash on delivery Successful'),
//                               actions: <Widget>[
//                                 // usually buttons at the bottom of the dialog
//                                 FlatButton(
//                                   child: new Text('Confirm'),
//                                   onPressed: () {
//                                     if (widget.status == 0) {
//                                       status = 1;
//                                     }
//                                     if (widget.transactionstatus == 0) {
//                                       transactionstatus = 1;
//                                     }
//                                     // _con.doDeliveredOrder(
//                                     //     _con.order);
//                                     // save(widget.invoiceid);
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                                 FlatButton(
//                                   child: new Text('dismiss'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           });
//                     },
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     color: appColor,
//                     shape: StadiumBorder(),
//                     child: Text(
//                       'Complete Delivery',
//                       style: TextStyle(fontSize: 18, color: Colors.white),

//                       // textAlign: TextAlign.start,
//                       // style:
//                       //     TextStyle(color: Theme.of(context).primaryColor),
//                     ),
//                   )),
//                 ],
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//     // body: Body(),);
//   }

//   Widget buildBottomRows({context, String title, String trailing}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         Text(
//           trailing,
//           style: TextStyle(fontSize: 16),
//         )
//       ],
//     );
//   }
// }
