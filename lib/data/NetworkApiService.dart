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
      final response =
          await http.get(Uri.parse(baseUrl + "listar/" + query)); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /*   final url = Uri.parse('https://example.com/api/get');
  final headers = <String, String>{'Content-Type': 'application/json'};
  final body = jsonEncode({'param1': 'value1', 'param2': 'value2'});

  final request = http.Request('GET', url);
  request.headers.addAll(headers);
  request.body = body;

  final response = await request.send();

  print('Status code: ${response.statusCode}');
  print('Response body: ${await response.stream.bytesToString()}'); */

  Future deleteResponse(String id) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(
        baseUrl,
      )); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postResponse(String body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(
        baseUrl,
      )); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

      ///EJEMPLO DE BODY
      ///
      //final body = jsonEncode({'username': 'john', 'password': 'password123'});

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future putResponse(String id) async {
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(
        baseUrl,
      )); //+ url
      //print("la URL TOLI :$baseUrl"); //+ url

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
