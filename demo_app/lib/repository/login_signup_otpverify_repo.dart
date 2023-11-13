import '../constants/api_constants.dart';
import '../network/BaseApiServices.dart';
import '../network/NetworkApiServices.dart';

class AuthRepository{

  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = _apiService.getPostApiResponse(ApiConstants.login_api, data,"null");
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> otpVerifyApi(dynamic data,String token) async{
    try{
      dynamic response = _apiService.getPostApiResponse(ApiConstants.otp_verify_api, data,token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async{
    try{
      dynamic response = _apiService.getPostApiResponse(ApiConstants.sign_up_api, data,"null");
      return response;
    }catch(e){
      throw e;
    }
  }



}