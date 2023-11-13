import 'dart:convert';
import 'dart:io';
import '../data/app_exceptions.dart';
import '../network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
class NetworkApiService extends BaseApiService {
  @override
  Future getGetResponse(String url,String token) async {
    dynamic responseJson;
    try{
       final response = await http.get(
           Uri.parse(url),
           headers: {"Authorization": "Bearer $token"}
       ).timeout(Duration(seconds: 10));
       responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data,String token) async {
    dynamic responseJson;
    if(token=="null"){
      try{
        final response = await http.post(
            Uri.parse(url),
            body: data
        ).timeout(Duration(seconds: 10));
        responseJson = returnResponse(response);
      }on SocketException{
        throw FetchDataException("No Internet Connection");
      }
      return responseJson;
    }else{
      try {
        final response = await http.post(
          Uri.parse(url),
          body: data,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ).timeout(Duration(seconds: 10));
        responseJson = returnResponse(response);
      } on SocketException {
        throw FetchDataException("No Internet Connection");
      }
      return responseJson;
    }

  }

  dynamic returnResponse(http.Response response){
    int statuscode = response.statusCode;
    dynamic responsejJson = jsonDecode(response.body);
    switch(response.statusCode){
      case 200:
        dynamic responsejJson = jsonDecode(response.body);
        return responsejJson;
      case 401:
        throw BadRequestException(responsejJson['message']);
      case 400:
        throw BadRequestException(responsejJson['message']);
      case 404:
        throw UnauthorizedException(responsejJson['message']);
      case 500:
        throw InternalServerError(responsejJson['message']);
      default:
        throw FetchDataException("Error accured while communicating with server with status code : $statuscode");
    }
  }

}