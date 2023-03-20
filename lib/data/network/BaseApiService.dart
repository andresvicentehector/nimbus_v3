abstract class BaseApiService {
  final String baseUrl = "http://35.180.113.93:3000/";

  Future<dynamic> getResponse(String query);
  Future<dynamic> deleteResponse(String id);
  Future<dynamic> postResponse(String body);
  Future<dynamic> putResponse(String body);
}
