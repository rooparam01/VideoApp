

import 'package:DemoVideoApp/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../basic_screens/Home.dart';
import '../../basic_screens/splash_screen.dart';
import '../../screens/landing_page/landing_page.dart';
import '../../screens/login_page_otp_verification/loginpage.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>LoginScreen());
      case RouteName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>MyHomePage());
      case RouteName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashScreen());
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (BuildContext context)=>CreateUserVideoScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}