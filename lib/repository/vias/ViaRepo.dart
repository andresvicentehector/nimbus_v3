import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';

class ViaRepo {
  Future<ViaAWS?> getViasList(String query) async {}
  Future<ViaAWS?> deleteVia(String id) async {}
  Future<ViaAWS?> updateVia(Map<String, dynamic> body, String endpoint) async {}
}
