import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'network/AppException.dart';
import 'network/BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String query) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + query)); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future deleteResponse(String id) async {
    dynamic responseJson;
    try {
      final response =
          await http.delete(Uri.parse(baseUrl + "borrar/$id")); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postResponse(Map<String, dynamic> body, String endpoint) async {
    dynamic responseJson;
    try {
      final bodyenco = jsonEncode(body);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.post(Uri.parse(baseUrl + endpoint),
          body: bodyenco, headers: headers); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future putResponse(Map<String, dynamic> body, String endpoint) async {
    dynamic responseJson;
    print(body);
    final bodyenco = jsonEncode(body);
    // Define the headers for the PUT request
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };

    try {
      final response = await http.put(
          Uri.parse(
            baseUrl + endpoint,
          ),
          headers: headers,
          body: bodyenco); //+ url
      print("la URL TOLI :$baseUrl+ $endpoint"); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
