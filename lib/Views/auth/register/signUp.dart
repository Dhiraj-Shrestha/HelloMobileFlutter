import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/auth/appbar/appbar.dart';
import 'package:hello_mobiles/Views/termsAndCondition/termsAndCondition.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/Widgets/passwordField.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/Widgets/textFieldWidget.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:hello_mobiles/routes/router_constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // //Top part of login design
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset("assets/images/register.png",
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width / 2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          child: Text(
                        'Register Here',
                        style: largeTextStyle,
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height / 25),
                      TextFieldWidget(
                        controller: nameController,
                        labelText: 'Full Name',
                        name: 'String',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kNameNullError),
                        ]),
                        inputType: TextInputType.name,
                      ),
                      TextFieldWidget(
                        controller: emailController,
                        labelText: 'Your Email',
                        name: 'email',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kEmailNullError),
                          FormBuilderValidators.email(context,
                              errorText: kInvalidEmailError)
                        ]),
                        inputType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        controller: phoneController,
                        labelText: 'Phone Number',
                        name: 'number',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kPhoneNumberNullError),
                          FormBuilderValidators.numeric(context,
                              errorText: kInvalidPhoneNumberNullError),
                          FormBuilderValidators.match(
                              context, phoneValidatorRegExp,
                              errorText: 'Enter valid number'),
                        ]),
                        inputType: TextInputType.number,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
                        child: DropdownButtonFormField(
                          hint: Text('Please choose a city'),
                          // Not necessary for Option 1
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                          ),
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                      TextFieldWidget(
                        controller: areaController,
                        labelText: 'Area',
                        name: 'area',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kAddressNullError),
                        ]),
                        inputType: TextInputType.text,
                      ),
                      TextFieldWidget(
                        controller: wardController,
                        labelText: 'Ward',
                        name: 'ward',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kAddressNullError),
                        ]),
                        inputType: TextInputType.number,
                      ),
                      TextFieldWidget(
                        controller: addressController,
                        labelText: 'Near By (Optional)',
                        name: 'address',
                        inputType: TextInputType.text,
                      ),
                      PasswordField(
                        obsscureText: _obscureText1,
                        controller: passwordController,
                        onTap: () {
                          _toggle1();
                        },
                        labelText: 'Password',
                        name: 'password',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kPassNullError),
                          FormBuilderValidators.minLength(context, 8,
                              errorText: kShortPassError),
                        ]),
                      ),
                      PasswordField(
                        controller: confrimPasswordController,
                        obsscureText: _obscureText2,
                        onTap: () {
                          _toggle2();
                        },
                        labelText: 'Confirm Password',
                        name: 'confirmpassword',
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kConfirmPassNullError),
                          FormBuilderValidators.match(
                              context, passwordController.text,
                              errorText: kMatchPassError)
                        ]),
                      ),
                    ],
                  ),
                ),
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
                            });
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        children: [
                          Text(
                            "Accept our",
                          ),
                          InkWell(
                            onTap: () {
                              _displayTextInputDialog(context);
                            },
                            child: Text(
                              ' policy & Terms ',
                              style: TextStyle(
                                color: appColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            "of Service ",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ButtonWidget(
                  buttonColor: appColor,
                  borderColor: appColor,
                  buttonName: 'Sign Up',
                  borderRadius: 12.0,
                  textColor: Colors.white,
                  onPressed: checkBoxValue ? () async => formCheck() : null,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, signInRoute);
                          },
                          child: Text(
                            "Sign In",
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
    );
  }

  bool checkBoxValue = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController wardController = new TextEditingController();

  TextEditingController addressController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  TextEditingController confrimPasswordController = new TextEditingController();

  List<String> _locations = [
    'Itahari',
    'Biratnagar',
    'Dharan',
    'Dhankuta',
    'Bhedetar'
  ]; // Option 2
  String _selectedLocation; // Option 2
  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText2 = true;

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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: TermsAndCondiion(),
        );
      },
    );
  }

  void formCheck() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map data = {
        'name': nameController.text,
        'email': emailController.text,
        'phoneNumber': phoneController.text,
        'password': passwordController.text,
        'password_confirmation': confrimPasswordController.text,
        'city': _selectedLocation,
        'area': areaController.text,
        'ward': wardController.text,
        'address': addressController.text,
      };

      var response = await Api().loginRegister(data, 'register');
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        Navigator.popAndPushNamed(context, signInRoute);
        showSimpleSnackBar(
            context: context,
            title: 'You have been successfully registered',
            message: 'Enter login credentials to log in');
      } else {
        setState(() {});
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('error'),
                content: Text(result['message'].toString()),
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
  }
}
