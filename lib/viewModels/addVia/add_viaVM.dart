import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../repository/vias/ViaRepoImp.dart';
import '../../template/configuration/ConstantesPropias.dart';

class AddViaVM extends ChangeNotifier {
  final _myRepo = ViaRepoImp();

  ApiResponse<ViaAWS> addViasMain = ApiResponse.loading();
  final nameController = TextEditingController();
  final autorController = TextEditingController();
  int dificultadController = Colors.green.value;
  final comentarioController = TextEditingController();
  late String isBloqueControler = "Travesía";
  late var width;
  late var height;
  late final Box box;
  String bloque = "Bloque";
  String travesia = "Travesía";

  //el parametro de entrada es la clase api response que coje la clase movie como parametro de entrada y devuelve una respuesta
  void _addMain(ApiResponse<ViaAWS> response) {
    //print("Response :: $response");
    addViasMain = response;
    // notifyListeners();
  }

  /*void _setMovieMainHive(HiveResponse<MovieHive> response) {
    //print(" :: $response");
    movieMainhive = response;
    notifyListeners();
  } */

//the only way to access to movie list from the ui
  Future<void> addNewVia(Map<String, dynamic> body) async {
    String endpoint = "guardar/";

    if (await InternetConnectionChecker().hasConnection) {
      _addMain(ApiResponse.loading());

      _myRepo
          .addVia(body, endpoint)
          .then((value) => _addMain(ApiResponse.completed(value)))
          .onError((error, stackTrace) =>
              _addMain(ApiResponse.error(error.toString())));
    } else {
      // fetchViasFromHive();
    }
  }

  String? fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede quedar vacío';
    }
    return null;
  }

  // Add info to people box
  addInfo(
    List<String> presas,
  ) async {
    int versionint = int.parse(version);

    Map<String, dynamic> body = {
      'name': '${nameController.text.trimRight()}',
      'autor': '${autorController.text.trimRight()}',
      'dificultad': dificultadController,
      'comentario': '${comentarioController.text.trimRight()}',
      'presas': presas,
      'quepared': versionint,
      'isbloque': '$isBloqueControler'
    };
    /* Via newVia = Via(
        name: _nameController.text,
        autor: _autorController.text,
        dificultad: _dificultadController,
        comentario: _comentarioController.text,
        presas: widget.presas,
        isbloque: _isBloqueControler,
        quepared: version == '25' ? 25 : 15);*/

    //box.add(newVia);
    //print(newVia);

    addNewVia(body);
  }

  void changeColor(Color newColor) {
    Color c1 = newColor;
    dificultadController = c1.value;
  }

  setBloque(dynamic val) {
    isBloqueControler = val;
  }
}
