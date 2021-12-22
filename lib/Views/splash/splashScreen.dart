import 'package:hello_mobiles/Views/Selection.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/images.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SizeConfig();
    checkToken();
  }

  void checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    print(token);
    if (token == null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SelectionPage()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, mainRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Hero(
                        tag: "splashscreenImage",
                        child: new Container(child: Images.appLogo),
                      ),
                      radius: MediaQuery.of(context).size.height / 4,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                    ),
                  ],
                )),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(appColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
