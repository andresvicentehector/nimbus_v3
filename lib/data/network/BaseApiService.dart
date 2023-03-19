abstract class BaseApiService {
  final String baseUrl = "http://35.180.97.169:3000/listar/";

  Future<dynamic> getResponse(String query);
}
