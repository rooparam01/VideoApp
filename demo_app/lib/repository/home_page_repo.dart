

import '../constants/api_constants.dart';
import '../model/home_one_model.dart';
import '../network/BaseApiServices.dart';
import '../network/NetworkApiServices.dart';

class HomeRepository{

  BaseApiService _apiService = NetworkApiService();

  Future<HomeOneModel> homepageGetData(String token) async{
    try{
      dynamic response = await _apiService.getGetResponse(ApiConstants.home_page_api,token);
        return HomeOneModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}