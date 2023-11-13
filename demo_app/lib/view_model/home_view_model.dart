
import 'package:flutter/cupertino.dart';

import '../constants/token_manager.dart';
import '../data/response/api_response.dart';
import '../model/home_one_model.dart';
import '../repository/home_page_repo.dart';

class HomeViewModel with ChangeNotifier{
  final _myrepo = HomeRepository();

  ApiResponse<HomeOneModel> dataList = ApiResponse.loading();

  setDataList(ApiResponse<HomeOneModel> response){
    dataList = response;
    notifyListeners();
  }

  Future<void> fetchDataFromApi()async{
    setDataList(ApiResponse.loading());
    final token = await TokenManager.getToken();
    _myrepo.homepageGetData(token!).then((value) => {
    setDataList(ApiResponse.completed(value))
    }).onError((error, stackTrace) => {
      setDataList(ApiResponse.error(error.toString()))
    });
  }

}