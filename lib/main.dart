import 'package:flutter/material.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'routes/router.dart';
import 'routes/router_constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ProductData>(
      builder: (context) => ProductData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("cbf93a64-4213-45e0-ab74-867910584e2b", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: appColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: appColor),
              actionsIconTheme: IconThemeData(color: appColor)),
        ),
        onGenerateRoute: Routers.onGenerateRoute,
        initialRoute: splashRoute);
  }
}
