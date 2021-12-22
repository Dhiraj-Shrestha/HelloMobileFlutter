import 'package:flutter/material.dart';

const MaterialColor appColor = MaterialColor(
  appColorRGB,
  <int, Color>{
    50: Color.fromRGBO(170, 69, 98, 0.1),
    100: Color.fromRGBO(170, 69, 98, 0.2),
    200: Color.fromRGBO(170, 69, 98, 0.3),
    300: Color.fromRGBO(170, 69, 98, 0.4),
    400: Color.fromRGBO(170, 69, 98, 0.5),
    500: Color(appColorRGB),
    600: Color.fromRGBO(170, 69, 98, 0.7),
    700: Color.fromRGBO(170, 69, 98, 0.8),
    800: Color.fromRGBO(170, 69, 98, 0.9),
    900: Color.fromRGBO(170, 69, 98, 1),
  },
);
const int appColorRGB = 0xffAA4562;

TextStyle greyStyle =
    TextStyle(color: Colors.grey, fontSize: 15, letterSpacing: 0.8);

TextStyle headingStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
TextStyle largeTextStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700, color: appColor);

TextStyle subHeadingStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600);

final String url = 'http://192.168.1.86:8000/';

// final String url = 'http://192.168.42.237:8000/';

final String productImageSource = url + 'uploadedFiles/';
final String secondHandSale = url + 'api/secondhandproducts';

final String secondHandImageSource = url + 'secondhand/detailImage/';
// Form Error

final String phoneValidatorRegExp = r"^(?:[+0]9)?[0-9]{10}$";
final String strongPasswordRegExp = r'.*[@$#.*].*';
const String kNameNullError = "Please enter your name";
const String kEmailNullError = "Please enter your email";
const String kPriceNullError = "Please enter price";
const String kDescriptionNullError = "Please enter description";
const String kInvalidEmailError = "Please enter valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password length should be minimum 8";
const String kStrongPasswordNullError =
    "Must contain special character either . * @ # \$";
const String kMatchPassError = "Passwords don't match";

const String kConfirmPassNullError = "Re type your password";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kInvalidPhoneNumberNullError = "Please enter a valid phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: appColor),
  );
}

var textFormFieldRegular = TextStyle(
    fontSize: 16,
    fontFamily: "Helvetica",
    color: Colors.black,
    fontWeight: FontWeight.w400);

var textFormFieldLight =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

var textFormFieldMedium =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

var textFormFieldSemiBold =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

var textFormFieldBold =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

var textFormFieldBlack =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);
