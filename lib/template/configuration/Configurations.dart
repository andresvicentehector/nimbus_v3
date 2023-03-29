import '../../models/ListadoVias/AWS/ViaAWS.dart';

abstract class Configurations {
  String get quePared;
  String get fondo;
  String get paredTrans;
  String get version;

  Vias get viaData;
  String? get indexData;
}
