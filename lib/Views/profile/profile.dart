import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/profile/changePassword.dart';
import 'package:hello_mobiles/Views/profile/profileCardMenu.dart';
import 'package:hello_mobiles/Views/profile/profileImage.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfileUpdate(),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RichText(
                // overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    text: "Saman KC"),
              ),
            ),
            ProfileCartMenu(
              text: "Change Password",
              icon: FontAwesomeIcons.userLock,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                ),
              },
            ),
            ProfileCartMenu(
              text: "Notifications",
              icon: FontAwesomeIcons.bell,
              onPressed: () {
                Navigator.pushNamed(context, notificationRoute);
              },
            ),
            ProfileCartMenu(
              text: "My Orders",
              icon: Icons.inventory,
              onPressed: () {
                Navigator.pushNamed(context, invoiceRoute);
              },
            ),
            ProfileCartMenu(
              text: "About Us",
              icon: FontAwesomeIcons.addressBook,
              onPressed: () {
                Navigator.pushNamed(context, aboutRoute);
              },
            ),
            ProfileCartMenu(
              text: "Terms & Condition",
              icon: FontAwesomeIcons.fileContract,
              onPressed: () {
                Navigator.pushNamed(context, termsAndConditionRoute);
              },
            ),
            ProfileCartMenu(
              text: "Log Out",
              icon: FontAwesomeIcons.signOutAlt,
              onPressed: () async {
                Map data = {};
                var response = await Api().logOut(data, 'logout');
                var result = json.decode(response.body);
                if (result['code'] == 200) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('token');
                  Navigator.popAndPushNamed(context, signInRoute);
                } else {
                  print(result['code']);
                  print("fail");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
