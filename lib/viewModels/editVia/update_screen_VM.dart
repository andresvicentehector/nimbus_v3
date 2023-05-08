import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../repository/vias/ViaRepoImp.dart';
import '../../template/configuration/ConstantesPropias.dart';

class UpdateScreenVM extends ChangeNotifier {
  final _myRepo = ViaRepoImp();

  ApiResponse<ViaAWS> updateViasMain = ApiResponse.loading();

  late int dificultadController;

  late String isBloqueController;

  late final nameController;
  late final autorController;

  late final comentarioController;
  late final Box box;

  //el parametro de entrada es la clase api response que coje la clase movie como parametro de entrada y devuelve una respuesta
  void _updateMain(ApiResponse<ViaAWS> response) {
    //print("Response :: $response");
    updateViasMain = response;
    // notifyListeners();
  }

  /*void _setMovieMainHive(HiveResponse<MovieHive> response) {
    //print(" :: $response");
    movieMainhive = response;
    notifyListeners();
  } */

//the only way to access to movie list from the ui
  Future<void> actualizarVia(Map<String, dynamic> body, String id) async {
    String endpoint = "editar/$id";

    if (await InternetConnectionChecker().hasConnection) {
      _updateMain(ApiResponse.loading());

      _myRepo
          .updateVia(body, endpoint)
          .then((value) => _updateMain(ApiResponse.completed(value)))
          .onError((error, stackTrace) =>
              _updateMain(ApiResponse.error(error.toString())));
    } else {
      // fetchViasFromHive();
    }
  }

  String? fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'no puedes dejar este campo vacío';
    }
    return null;
  }

  // Update info of via box
  updateInfo(
      dynamic _nameController,
      _autorController,
      _dificultadController,
      _comentarioController,
      _isBloqueController,
      List<String> presas,
      String id) async {
    int versionint = int.parse(version);

    Map<String, dynamic> body = {
      'name': '$_nameController',
      'autor': '$_autorController',
      'dificultad': _dificultadController,
      'comentario': '$_comentarioController',
      'presas': presas,
      'quepared': versionint,
      'isbloque': '$_isBloqueController'
    };

    actualizarVia(body, id);

    print(body.values);
    // notifyListeners();

    /* Via newVia = Via(
                              name: _nameController.text,
                              autor: _autorController.text,
                              dificultad: _dificultadController,
                              comentario: _comentarioController.text,
                              presas: widget.via.presas,
                              isbloque: _isBloqueController,
                              quepared: version == '25' ? 25 : 15);
                              */

    //box.put(widget.via.sId, newVia);

    //print('Info updated in box!');
  }

  void setNewColor(Color newColor) {
    Color c1 = newColor;
    dificultadController = c1.value;
    // notifyListeners();
  }

  setBloque(dynamic val) {
    isBloqueController = val;
  }
}
