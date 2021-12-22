import 'package:flutter/material.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/utils/constant.dart';

class TermsAndCondiion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'Terms & Condition'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            termsAndCondition(
                context: context,
                count: 1,
                termText:
                    'Customer can request to sent request to sell their valid products which will be displayed in marketplace after approval from admin'),
            termsAndCondition(
                context: context,
                count: 2,
                termText:
                    'Goods that is prohibited by laws & regulation of Federal Democratic Republic of Nepal not allowed by Site.'),
            termsAndCondition(
                context: context,
                count: 3,
                termText:
                    'Invdivual who found guilty for sellng stolen or damanged products in secondhand market will be responsible and any legal charge applied to him/her will be acepatable.'),
            termsAndCondition(
                context: context,
                count: 4,
                termText:
                    'You are solely responsible and accountable for your content'),
            termsAndCondition(
                context: context,
                count: 5,
                termText:
                    'If you are using information from app, in order to communicate / sale / purchase any goods or services from other users, we strongly encourage you take necessary precaution to protect yourself.'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Privacy policy",
              style: TextStyle(
                  color: appColor, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Text(
                  'Protecting privacy is important to us but due to the nature of our business, some functions and services offered through our site requires user to provide certain personal information such as name, email address, contact address, phone numbers, etc for communication purpose and such information collected are provided to us voluntarily. Some of this information is displayed publicly in Internet and may be used by third parties, on whom we do not have any control. Similarly some of personal information is shared with other users in order to facilitate communication.',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget termsAndCondition({context, count, termText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        child: Text(
          count.toString() + ": " + termText,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
