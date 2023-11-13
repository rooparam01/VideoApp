import 'package:flutter_svg/svg.dart';

import '../resources/colors.dart';
import 'package:flutter/material.dart';
import '../resources/components/round_button.dart';
import '../screens/login_page_otp_verification/loginpage.dart';
import '../screens/login_page_otp_verification/sign_up_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: 428.0,
            height: 44.0,
            color: Color(0xFFF01B49E),
          ),
          Opacity(
            opacity: 0.3,
            child: Container(
              width: 428.0,
              height: 38.0,
              color: Color(0xFFF01B49E),
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              width: 428.0,
              height: 39.0,
              color: Color(0xFFF01B49E),
            ),
          ),
          const SizedBox(height: 40.0,),
          Container(
            height: 250,
            color: Color(0xFFF7F9F9),
            child: Center(
              child: SvgPicture.asset(
                'assets/home_pre_sign.svg',
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          const SizedBox(height: 32.0,),
          Container(
            width: 200.0,
            child: Column(
              children: [
                Text(
                  "Get Started with Us",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize:25, color: AppColors.appThemeColor),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  " Unlock the Power",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 70.0,),
          RoundButton(title: "Get Started",color:Color(0xFFcfcfcf) , onPress:()async{
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()),
            );
          }),
          const SizedBox(height: 20.0,),
          RoundButton(title: "Sign In", onPress:()async{
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            );
          }),
        ],
      ),
    );
  }
}



