import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';
import 'package:Nimbus/repository/vias/ViaRepo.dart';
import 'package:hive/hive.dart';

import '../../data/NetworkApiService.dart';
import '../../data/network/BaseApiService.dart';

class ViaRepoImp implements ViaRepo {
  BaseApiService _apiService = NetworkApiService();

  Box box = Hive.box("ViaBox");

  @override
  Future<ViaAWS?> getViasList(query) async {
    try {
      dynamic response = await _apiService.getResponse("/listar?" + query);
      //print("Json from API: $response"); //ese response es un JSON Que ha pillado de la API

      final jsonData = ViaAWS.fromJson(response);

      //final jsonDataHive = ViaAWS.fromJson(response);

      // await box.put(jsonData.page, jsonDataHive.results);
      //print("valores del box:" + box.keys.toString());
      //print("BOXSAVED");

      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<ViaAWS?> deleteVia(id) async {
    try {
      dynamic response = await _apiService.deleteResponse(id);

      final jsonData = ViaAWS.fromJson(response);

      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<ViaAWS?> updateVia(body) async {
    try {
      dynamic response = await _apiService.postResponse(body);

      final jsonData = ViaAWS.fromJson(response);

      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<ViaAWS?> addVia(body) async {
    try {
      dynamic response = await _apiService.putResponse(body);

      final jsonData = ViaAWS.fromJson(response);

      return jsonData;
    } catch (e) {
      throw e;
    }
  }
}
