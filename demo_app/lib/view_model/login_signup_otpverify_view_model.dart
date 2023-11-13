
import 'package:DemoVideoApp/screens/landing_page/home_app_bar.dart';
import 'package:DemoVideoApp/screens/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import '../constants/shared_preference_values.dart';
import '../screens/login_page_otp_verification/otp_verify_screen.dart';
import '../utils/utils.dart';

class AuthViewModel extends ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }


  Future<void> loginApi(dynamic data,BuildContext context,String phonecode,String mobileno)async{
    setLoading(true);
    if(mobileno=='1234567890'){
      setLoading(false);
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => OTPScreen(
      countrycode: phonecode,
      mobileNumber: mobileno,
      )));
    }else{
      setLoading(false);
      Utils.flushBarSuccessMessage("Invalid Mobile Number Please Use 1234567890",context);
    }
  }

  bool _otploading = false;
  bool get otploading => _otploading;

  setotploading(bool value){
    _otploading=value;
    notifyListeners();
  }

  Future<void> OtpVerifyApi(dynamic data,BuildContext context)async{
    setotploading(true);
    if(data['otp']=='12345'){
      setotploading(false);
      ValueStore.setisLogin("true");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateUserVideoScreen()));
    }else{
      setotploading(false);
      Utils.flushBarErrorMessage("Invalid OTP Please Use 12345",context);
    }
  }

  bool _signuploading = false;
  bool get signuploading => _signuploading;

  setsignuploading(bool value){
    _signuploading=value;
    notifyListeners();
  }

  Future<void> SignUpApi(dynamic data,BuildContext context,String phonecode,String mobileno)async{
      setsignuploading(false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(countrycode: phonecode, mobileNumber: mobileno)));
  }

}