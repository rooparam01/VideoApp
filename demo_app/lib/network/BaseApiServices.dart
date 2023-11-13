abstract class BaseApiService{
  Future<dynamic> getGetResponse(String url,String token);

  Future<dynamic> getPostApiResponse(String url,dynamic data,String token);
}