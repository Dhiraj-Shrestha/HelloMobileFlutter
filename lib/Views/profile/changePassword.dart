import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/passwordField.dart';
import 'package:hello_mobiles/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Form
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _currentPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  int customerId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    print(data);
    setState(() {
      customerId = data['id'];
      isLoading = false;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // save(customerId);
        setState(() {});
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Password changed successfully"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future save(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final uri = Uri.parse(url + 'api/profile/$id?_method=PUT');

    MultipartRequest request = http.MultipartRequest('post', uri);

    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ' + token;
    request.fields['current_password'] = _currentPass.text;
    request.fields['new_password'] = _pass.text;
    // request.fields['confirm_password'] = _confirmPass.text;
    // request.fields['price'] = _confirmPass.text;
    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    var result = json.decode(response.body);
    print(result['code']);
    print(result['message']);

    // return response.body;

    // print(response.statusCode);
    if (result['code'] == 200) {
      showAlertDialog(context);

      // Navigator.pushReplacementNamed(context, mainRoute);
    } else {
      setState(() {});
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Update Failed'),
              content:
                  Text(result['message']['current_password'][0].toString()),
              actions: [
                RaisedButton(
                  onPressed: () {
                    // error = '';
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }
  }

  // String url = baseUrl + endPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'Change Password'),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      PasswordField(
                        name: 'Current Password',
                        controller: _currentPass,
                        obsscureText: _obscureText1,
                        onTap: () {
                          _toggle1();
                        },
                        labelText: 'Current Password',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kPassNullError),
                          FormBuilderValidators.minLength(context, 8,
                              errorText: kShortPassError),
                        ]),
                      ),
                      PasswordField(
                        name: 'New Password',
                        controller: _pass,
                        obsscureText: _obscureText2,
                        onTap: () {
                          _toggle2();
                        },
                        labelText: 'New Password',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kPassNullError),
                          FormBuilderValidators.minLength(context, 8,
                              errorText: kShortPassError),
                        ]),
                      ),
                      PasswordField(
                        name: 'New Password',
                        controller: _confirmPass,
                        obsscureText: _obscureText3,
                        onTap: () {
                          _toggle3();
                        },
                        labelText: 'New Password',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kPassNullError),
                          FormBuilderValidators.match(context, _pass.text,
                              errorText: kMatchPassError)
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                          buttonColor: appColor,
                          borderColor: appColor,
                          textColor: Colors.white,
                          borderRadius: 12.0,
                          onPressed: () {
                            save(customerId);
                          },
                          buttonName: 'Change Password'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
