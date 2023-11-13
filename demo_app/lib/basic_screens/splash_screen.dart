import 'package:flutter/services.dart';
import '../basic_screens/Home.dart';
import '../constants/shared_preference_values.dart';
import '../resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/landing_page/landing_page.dart';
import 'GetStartedScreens/getStartedSlider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var isSlideShow;

  var isLogin;


  @override
  void initState(){
    super.initState();
    checkForSlideShow().then((value) async => {
      Future.delayed(Duration(seconds: 2), () {
        isLogin=='true'?Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => CreateUserVideoScreen()),
        ):
        isSlideShow==true?Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
        ):Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => IntroScreen()),
        );
      })
    });
  }

 Future<void> checkForSlideShow() async {
   isLogin = await ValueStore.getisLogin();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSlideShow = prefs.getBool("isSlideShow");
  }

  @override
    Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.appThemeColor,
        statusBarColor: Colors.transparent,
      ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 300),
                Image.asset(
                  'assets/icons.jpg',  // Replace with the actual path to your image
                  width: 30,  // Adjust the width as needed
                  height: 30, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                Text("Please Wait Splash Screen"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}