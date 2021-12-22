import 'package:flutter/material.dart';
import 'package:hello_mobiles/Views/AboutUs/aboutUs.dart';
import 'package:hello_mobiles/Views/FAQ/faq.dart';

import 'package:hello_mobiles/Views/HomeScreen/Homepage.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/categoriesCard.dart';
import 'package:hello_mobiles/Views/invoice/invoice.dart';
import 'package:hello_mobiles/Views/notification/notification.dart';
import 'package:hello_mobiles/Views/subCategory/subcategories.dart';
import 'package:hello_mobiles/Views/Selection.dart';
import 'package:hello_mobiles/Views/auth/forgetPassword/forgetPassword.dart';
import 'package:hello_mobiles/Views/auth/forgetPassword/otp/otp.dart';
import 'package:hello_mobiles/Views/auth/register/signUp.dart';
import 'package:hello_mobiles/Views/cart/cartScreen.dart';
import 'package:hello_mobiles/Views/chatWithAdmin/soicalSiteAdmin.dart';
import 'package:hello_mobiles/Views/mainscreen/Landing.dart';
import 'package:hello_mobiles/Views/onboard/onBoardPage.dart';
import 'package:hello_mobiles/Views/secondHandSale/secondHandSale.dart';
// import 'package:hello_mobiles/Views/secondhandproduct/secondhanddetails.dart';
import 'package:hello_mobiles/Views/secondhandproduct/secondhandproduct.dart';
import 'package:hello_mobiles/Views/splash/splashScreen.dart';
import 'package:hello_mobiles/Views/auth/login/signIn.dart';
import 'package:hello_mobiles/Views/termsAndCondition/termsAndCondition.dart';
import 'package:hello_mobiles/Views/wishlist/wishlist.dart';
import 'package:hello_mobiles/map/shopLocation.dart';

import 'router_constants.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case selectRoute:
        return MaterialPageRoute(builder: (_) => SelectionPage());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case signInRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case categoryRoute:
        return MaterialPageRoute(builder: (_) => Categories());
      case subCategoryRoute:
        return MaterialPageRoute(builder: (_) => SubCategories());
      case onBoardRoute:
        return MaterialPageRoute(builder: (_) => OnBoardPage());
      case homePageRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case cartRoute:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case shopLocationRoute:
        return MaterialPageRoute(builder: (_) => ShopLocation());
      case secondHandSaleRoute:
        return MaterialPageRoute(builder: (_) => SecondHandSale());
      case otpRoute:
        return MaterialPageRoute(builder: (_) => OtpCode());

      case faqRoute:
        return MaterialPageRoute(builder: (_) => FAQPage());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => Aboutus());
      case secondHandProductRoute:
        return MaterialPageRoute(builder: (_) => SecondHandProduct());
      case socialSiteAdminRoute:
        return MaterialPageRoute(builder: (_) => SoicalSiteAdmin());
      case wishListRoute:
        return MaterialPageRoute(builder: (_) => WishlistScreen());
      case notificationRoute:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case invoiceRoute:
        return MaterialPageRoute(builder: (_) => Invoice());
      case termsAndConditionRoute:
        return MaterialPageRoute(builder: (_) => TermsAndCondiion());

      // case secondHandDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => SecondHandProductDetail());
      default:
        return MaterialPageRoute(builder: (_) => SignUpPage());
    }
  }
}
