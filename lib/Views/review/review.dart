import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/utils/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  final mydata;

  const ReviewPage({Key key, this.mydata}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();
  Future getReview() async {
    try {
      var response = await Api().getData("review/${widget.mydata['id']}");
      var products = json.decode(response.body)['data'];
      print(products);
      return products;
    } on SocketException {
      return null;
    }
  }

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print("chutyako");
    print(id);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Give Product Review'),
            content: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
                child: FormBuilderTextField(
                  name: 'Feedback',
                  decoration: InputDecoration(
                    labelText: 'Feedback',
                    focusColor: appColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.2, color: appColor),
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                    fillColor: appColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: kDescriptionNullError),
                  ]),
                  autovalidateMode: AutovalidateMode.disabled,
                  maxLines: 3,
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  controller: _textFieldController,
                ),
              ),
            ),
            // content: TextField(
            //   onChanged: (value) {
            //     setState(() {
            //       valueText = value;
            //     });
            //   },
            //   controller: _textFieldController,
            //   decoration: InputDecoration(hintText: "Feedback"),
            // ),
            actions: <Widget>[
              FlatButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: appColor,
                textColor: Colors.white,
                child: Text('Post'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Map data = {
                      "product_id": widget.mydata['id'],
                      "comment": _textFieldController.text
                    };
                    var response = await Api().postData(data, 'review');

                    var result = jsonDecode(response.body);
                    if (result['code'] == 200) {
                      _textFieldController.text = '';
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      Navigator.pop(context);
                      showSimpleSnackBar(
                          context: context,
                          title: 'Thank You for your feedback');

                      print("success");
                      // showInSnackBar(context, 'Thank You for review');
                    } else {
                      print("fail");
                    }
                    // showInSnackBar(context, 'Thank You for review');

                    // Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  String codeDialog;
  String valueText;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  _displayTextInputDialog(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Give Review",
                    style: TextStyle(
                        color: appColor, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.black12,
              height: 1.0,
            ),
          ),

          // ListView.builder(itemBuilder: (conext, index) {
          //   shr
          //   return Text("hlw");
          // }),
          Container(
            child: FutureBuilder(
              future: getReview(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(child: Text("No Review Yet")),
                        )
                      : Container(
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var mydata = snapshot.data[index];
                                return Card(
                                  elevation: 0.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              mydata['profileImage'] == null
                                                  ? AssetImage(
                                                      'assets/images/userImage.png',
                                                    )
                                                  : NetworkImage(
                                                      url +
                                                          'profileImage/' +
                                                          mydata[
                                                              'profileImage'],
                                                    ),
                                        ),
                                        title: Text(mydata['name']),
                                        trailing: Text(
                                          mydata['reviewDate'].toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Container(
                                            width: double.infinity,
                                            child: Text(
                                              mydata['comment'],
                                              textAlign: TextAlign.justify,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );

                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: 3,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       // var mydata = snapshot.data[index];
                  //       return Text("hlw review");
                  //       // return ListTile(
                  //       //   // leading: Container(
                  //       //   //   height: 45.0,
                  //       //   //   width: 45.0,
                  //       //   //   decoration: BoxDecoration(
                  //       //   //       image: DecorationImage(
                  //       //   //           image: NetworkImage(mydata['image']),
                  //       //   //           fit: BoxFit.cover),
                  //       //   //       borderRadius:
                  //       //   //           BorderRadius.all(Radius.circular(50.0))),
                  //       //   // ),
                  //       //   title: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     children: <Widget>[
                  //       //       Text(mydata['name']),
                  //       //       Text(
                  //       //         mydata['review_date'],
                  //       //         style: TextStyle(fontSize: 12.0),
                  //       //       )
                  //       //     ],
                  //       //   ),
                  //       //   subtitle: Text(
                  //       //     mydata['comment'],
                  //       //   ),
                  //       // );
                  //     });
                } else {
                  return LinearProgressIndicator();
                }
              },
            ),
          ),

          //   ListView.builder(
          //       shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       itemCount: 8,
          //       itemBuilder: (context, index) {
          //         return Card(
          //           elevation: 0.0,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               ListTile(
          //                 leading: CircleAvatar(
          //                   backgroundColor: appColor,
          //                 ),
          //                 title: Text("Dhiraj Shrestha"),
          //                 trailing: Text(
          //                   "2020-12-12",
          //                   style: TextStyle(color: Colors.grey),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 15.0),
          //                 child: Container(
          //                     width: double.infinity,
          //                     child: Text(
          //                         "This is good product hehturhtu  uut ueuue uetututu tuu  uu eutye uteuu ut utu eyuietutuet u hueu  uyeueu eiueuewuteuyeuityeuiyeuyeuyeueu yue yguey ueygueyiu yeu yuiryeuyiu ryrui ")),
          //               )
          //             ],
          //           ),
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
