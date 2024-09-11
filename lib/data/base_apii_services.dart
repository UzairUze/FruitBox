abstract class BaseApiServices {
  ///for post and get api using in network api services class
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(dynamic data, String url);
}
