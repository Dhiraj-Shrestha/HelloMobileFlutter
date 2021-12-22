import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/auth/appbar/appbar.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/passwordField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/Widgets/textFieldWidget.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // //Top part of login design
                  Container(
                    child: Image.asset(
                      "assets/images/login.png",
                      fit: BoxFit.contain,
                      width: getProportionateScreenWidth(200),
                      // width: MediaQuery.of(context).size.width / 1.7,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Text(
                    'Welcome Back',
                    style: largeTextStyle,
                  )),
                  // SizedBox(height: MediaQuery.of(context).size.height / 25),
                  SizedBox(height: getProportionateScreenHeight(25)),
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
                  PasswordField(
                    obsscureText: _obscureText1,
                    labelText: 'Password',
                    onTap: () {
                      _toggle1();
                    },
                    name: 'password',
                    controller: passwordController,
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: kPassNullError),
                      FormBuilderValidators.minLength(context, 8,
                          errorText: kShortPassError),
                    ]),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Checkbox(
                                value: checkBoxValue,
                                activeColor: appColor,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkBoxValue = newValue;
                                    print(checkBoxValue);
                                  });
                                }),
                          ),
                          Text(
                            "Remember Password",
                          )
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, forgetPasswordRoute);
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(color: appColor, fontSize: 12),
                          )),
                    ],
                  ),
                  ButtonWidget(
                    buttonColor: appColor,
                    borderColor: appColor,
                    buttonName: 'Sign In',
                    borderRadius: 12.0,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Map data = {
                          'email': emailController.text,
                          'password': passwordController.text,
                          'oneSignal': oneSignalUserId
                        };
                        var response = await Api().loginRegister(data, 'login');
                        var result = json.decode(response.body);

                        if (result['code'] == 200) {
                          print(emailController.text);
                          print(passwordController.text);
                          print(result['code']);
                          print(result['message']);
                          print(result['token']);
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString('token', result['token']);

                          Navigator.pushReplacementNamed(context, mainRoute);
                        } else if (result['code'] == 422) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('message'),
                                  content: Text(result['errors'].toString()),
                                  actions: [
                                    RaisedButton(
                                      onPressed: () {
                                        error = '';
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    )
                                  ],
                                );
                              });
                        } else {
                          error = result['message'];
                          setState(() {});
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(result['message']),
                                content: Text(error.toString()),
                                actions: [
                                  RaisedButton(
                                    onPressed: () {
                                      error = '';
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not registered yet? "),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, signUpRoute);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: appColor),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String oneSignalUserId;
  void oneSignal() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    // the user's ID with OneSignal
    oneSignalUserId = status.subscriptionStatus.userId;
    print('this is onesignal user id');
    print(oneSignalUserId);
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  var error = '';
  bool checkBoxValue = false;
  // Initially password is obscure
  bool _obscureText1 = true;

  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  void initState() {
    super.initState();
    oneSignal();
  }
}
