import 'package:DemoVideoApp/resources/colors.dart';
import 'package:DemoVideoApp/utils/routes/routes.dart';
import 'package:DemoVideoApp/utils/routes/routes_name.dart';
import 'package:DemoVideoApp/view_model/login_signup_otpverify_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splash,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          primaryColor: AppColors.appThemeColor,
          appBarTheme:AppBarTheme(
            color: AppColors.appThemeColor,
          ),
        ),
      ),
    );

  }
}
