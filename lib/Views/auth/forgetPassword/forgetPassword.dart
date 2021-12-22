import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/textFieldWidget.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:hello_mobiles/Api/Api.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  child: Image.asset(
                    "assets/images/forgetPassword.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width / 1.7,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    child: Text(
                  'Forget Password',
                  style: largeTextStyle,
                )),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ForgotPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  bool flag = false;

  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: 'Email',
            name: 'email',
            controller: emailController,
            validators: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: kEmailNullError),
              FormBuilderValidators.email(context,
                  errorText: kInvalidEmailError),
            ]),
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30),
          ButtonWidget(
              buttonColor: appColor,
              borderColor: appColor,
              borderRadius: 12.0,
              textColor: Colors.white,
              buttonName: flag == false ? "Continue" : "Loading",
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print(emailController.text);
                  setState(() {
                    flag = true;
                  });
                  Map data = {
                    'email': emailController.text,
                  };

                  // if all are valid then go to success screen

                  var response =
                      await Api().loginRegister(data, 'forgetPassword');

                  var result = json.decode(response.body);
                  setState(() {
                    flag = false;
                  });
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  print(result['status']);
                  print(result['message']);
                  // print(result['user_type']);
                  // getuserDetails();
                  if (result['status'] == true) {
                    Navigator.popAndPushNamed(context, signInRoute);
                    showSimpleSnackBar(
                        context: context,
                        title: 'Reset link has been sent in your mail');
                  } else {
                    setState(() {});
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(result["message"]),
                            actions: [
                              RaisedButton(
                                onPressed: () {
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
              }),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
