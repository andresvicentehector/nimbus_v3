//import 'package:Hector_Show_data/remote/network/ApiEndPoints.dart';

import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../data/response/ApiResponse.dart';
import '../../repository/vias/ViaRepoImp.dart';
import '../../template/ConstantesPropias.dart';
import '../../template/T8Colors.dart';
import '../../views/bluettothSetings/widgets/SelectBondedDevicePage.dart';

class ViasListVM extends ChangeNotifier {
  //Internal and private State of movie
  final _myRepo = ViaRepoImp();

  ApiResponse<ViaAWS> ViasMain = ApiResponse.loading();

  // late List<Results>? movieMainHive;
  //utilizaremos estas tres más tarde para los idiomas
  String page = "1";
  String lang = "en-US";
  String flagUrl = "assets/images/flags/usa.png";

  late TextEditingController editingController = TextEditingController();

  final controllerSideBar =
      SidebarXController(selectedIndex: 0, extended: true);

  late BluetoothDevice? selectedDevice;

  late Color colorBtrave = t8_colorPrimary;
  late Color colorBbloque = t8_colorPrimary;

  late List list, list2;

  late Box itemBox = Hive.box("Viabox");

  late Color colorDificultad;

  /*late Map<dynamic, dynamic>? raw = Map.fromEntries(itemBox
      .toMap()
      .entries
      .where((entry) => entry.value.quepared == int.parse(version)));
  late Map<dynamic, dynamic>? filteredraw = Map.fromEntries(itemBox
      .toMap()
      .entries
      .where((entry) => entry.value.quepared == int.parse(version)));*/

  late bool isBloque = false;
  late bool isTrave = false;

//el parametro de entrada es la clase api response que coje la clase movie como parametro de entrada y devuelve una respuesta
  void _setViasMain(ApiResponse<ViaAWS> response) {
    //print("Response :: $response");
    ViasMain = response;
    notifyListeners();
  }

  /*void _setMovieMainHive(HiveResponse<MovieHive> response) {
    //print(" :: $response");
    movieMainhive = response;
    notifyListeners();
  } */

//the only way to access to movie list from the ui
  Future<void> fetchVias(String query) async {
    print("query " + query);
    if (await InternetConnectionChecker().hasConnection) {
      _setViasMain(ApiResponse.loading());

      _myRepo
          .getViasList(query)
          .then((value) => _setViasMain(ApiResponse.completed(value)))
          .onError((error, stackTrace) =>
              _setViasMain(ApiResponse.error(error.toString())));
    } else {
      // fetchViasFromHive();
    }
  }

  /* Future<void> updatePageDown(
    String page1,
  ) async {
    page = (int.parse(page) - 1).toString();
    notifyListeners();
    fetchMovies(lang, page);
  }

  Future<void> updatePageUp(
    String page1,
  ) async {
    page = (int.parse(page) + 1).toString();
    notifyListeners();
    fetchMovies(lang, page);
  }

  Future<void> changeLang(String langu) async {
    if (langu == "en-US") {
      flagUrl = "assets/images/flags/usa.png";
    } else {
      flagUrl = "assets/images/flags/spain.png";
    }
    lang = langu;
  }

  Future<void> fetchViasFromHive() async {
    //_setMovieMain(ApiResponse.loading());
    // _myRepo.getMoviesListFromHive(page);
  }*/

  void filterbyName(TextEditingController _searchController) {
    if (_searchController.text == "") {
      //list = raw!.values.toList();
      //filteredraw = raw;
      colorBbloque = t8_colorPrimary;
      colorBtrave = t8_colorPrimary;
      colorDificultad = Colors.transparent;
      fetchVias("/listar?quepared=" + version);
      notifyListeners();
    } else {
      /*list = raw.values
          .where((item) =>
              item.name.toLowerCase() == _searchController.text.toLowerCase() ||
              item.name
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              item.autor.toLowerCase() ==
                  _searchController.text.toLowerCase() ||
              item.autor
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();

      filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
          (entry.value.name.toLowerCase() ==
                  _searchController.text.toLowerCase() ||
              entry.value.name
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              entry.value.autor.toLowerCase() ==
                  _searchController.text.toLowerCase() ||
              entry.value.autor
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase())) &&
          entry.value.quepared == int.parse(version)));*/

      colorBbloque = t8_colorPrimary;
      colorBtrave = t8_colorPrimary;
      colorDificultad = Colors.transparent;
    }

    isBloque = false;
    isTrave = false;
    fetchVias("/buscar?buscar=${_searchController.text}&quepared=" + version);
    print(version + "/${_searchController.text}");
    notifyListeners();
  }

  void filterbylevel(int color) {
    //si no esta seleccionado el filtro de bloque o trave
    if (isBloque == false && isTrave == false) {
      if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
        /* list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value))
              .toList(); 
        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            (entry.value.dificultad == Colors.pinkAccent.value ||
                entry.value.dificultad == Colors.pink.value) &&
            entry.value.quepared == int.parse(version)));*/

        fetchVias("quepared=" + version + "&dificultad=morado");

        colorDificultad = Colors.pink;
      } else if (color == Colors.orangeAccent.value ||
          color == Colors.orange.value) {
        /* list = raw!.values
                        .where((item) =>
                            item.dificultad == Colors.orange.value ||
                            item.dificultad == Colors.orangeAccent.value)
                        .toList();
                  filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
                      (entry.value.dificultad == Colors.orange.value ||
                          entry.value.dificultad == Colors.orangeAccent.value) &&
                      entry.value.quepared == int.parse(version)));*/

        colorDificultad = Colors.orange;
        fetchVias("quepared=" + version + "&dificultad=naranja");
      } else if (color == Colors.green) {
        //list = raw!.values.where((item) => item.dificultad == color).toList();
        /* filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            entry.value.dificultad == color &&
            entry.value.quepared == int.parse(version)));*/

        colorDificultad = Color(color);
        fetchVias("quepared=" + version + "&dificultad=verde");
      } else if (color == Colors.yellow) {
        //list = raw!.values.where((item) => item.dificultad == color).toList();

        /* filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
                    entry.value.dificultad == color &&
                    entry.value.quepared == int.parse(version)));*/

        colorDificultad = Color(color);
        fetchVias("quepared=" + version + "&dificultad=amarillo");
      } else if (color == Colors.black) {
        //list = raw!.values.where((item) => item.dificultad == color).toList();

        /* filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
                      entry.value.dificultad == color &&
                      entry.value.quepared == int.parse(version)));*/

        colorDificultad = Color(color);
        fetchVias("quepared=" + version + "&dificultad=negro");
      }
    }

    if (isBloque == true) {
      if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
        /* list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value) &&
                  element.isbloque == "Bloque")
              .toList();

        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            (entry.value.dificultad == Colors.pinkAccent.value ||
                entry.value.dificultad == Colors.pink.value) &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Bloque"));*/

        colorDificultad = Colors.pink;
        fetchVias("quepared=" + version + "&isbloque=Bloque&dificultad=morado");
      } else if (color == Colors.orangeAccent.value ||
          color == Colors.orange.value) {
        /*list = raw!.values
              .where((item) =>
                  (item.dificultad == Colors.orange.value ||
                      item.dificultad == Colors.orangeAccent.value) &&
                  item.isbloque == "Bloque")
              .toList();*/

        /*filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            (entry.value.dificultad == Colors.orange.value ||
                entry.value.dificultad == Colors.orangeAccent.value) &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Bloque"));*/

        colorDificultad = Colors.orange;
        fetchVias(
            "quepared=" + version + "&isbloque=Bloque&dificultad=naranja");
      } else if (color == Colors.green) {
        /*list = raw!.values
              .where((item) =>
                  item.dificultad == color && item.isbloque == "Bloque")
              .toList();

        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            entry.value.dificultad == color &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Bloque"));*/

        colorDificultad = Color(color);
        fetchVias("quepared=" + version + "&isbloque=Bloque&dificultad=verde");
      } else if (color == Colors.yellow) {
        colorDificultad = Color(color);
        fetchVias(
            "quepared=" + version + "&isbloque=Bloque&dificultad=amarillo");
      } else if (color == Colors.black) {
        colorDificultad = Color(color);
        fetchVias("quepared=" + version + "&isbloque=Bloque&dificultad=negro");
      }
    }

    if (isTrave == true) {
      if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
        /*list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value) &&
                  element.isbloque == "Travesía")
              .toList();

        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            (entry.value.dificultad == Colors.pinkAccent.value ||
                entry.value.dificultad == Colors.pink.value) &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Travesía"));*/

        colorDificultad = Colors.pink;
        fetchVias(
            "quepared=" + version + "&isbloque=Travesía&dificultad=morado");
      } else if (color == Colors.orangeAccent.value ||
          color == Colors.orange.value) {
        /*  list = raw!.values
              .where((item) =>
                  (item.dificultad == Colors.orange.value ||
                      item.dificultad == Colors.orangeAccent.value) &&
                  item.isbloque == "Travesía")
              .toList();

        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            (entry.value.dificultad == Colors.orange.value ||
                entry.value.dificultad == Colors.orangeAccent.value) &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Travesía"));*/

        colorDificultad = Colors.orange;
        fetchVias(
            "quepared=" + version + "&isbloque=Travesía&dificultad=naranja");
      } else if (color == Colors.green) {
        /*list = raw!.values
              .where((item) =>
                  item.dificultad == color && item.isbloque == "Travesía")
              .toList();

        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            entry.value.dificultad == color &&
            entry.value.quepared == int.parse(version) &&
            entry.value.isbloque == "Travesía"));*/

        colorDificultad = Color(color);
        fetchVias(
            "quepared=" + version + "&isbloque=Travesía&dificultad=verde");
      } else if (color == Colors.yellow) {
        colorDificultad = Color(color);
        fetchVias(
            "quepared=" + version + "&isbloque=Travesía&dificultad=amarillo");
      } else if (color == Colors.black) {
        colorDificultad = Color(color);
        fetchVias(
            "quepared=" + version + "&isbloque=Travesía&dificultad=negro");
      }
    }

    editingController.text = "";
    notifyListeners();
  }

  void filterbyblock(String isblock) {
    editingController.text = "";
    if (isblock == "nofilter") {
      //list = raw!.values.toList();
      //filteredraw = raw;

      colorDificultad = Colors.transparent;
      isBloque = false;
      isTrave = false;
      fetchVias("quepared=" + version);
    } else {
      if (isblock == "Bloque") {
        isBloque = true;
        isTrave = false;
        fetchVias("quepared=" + version + "&isbloque=Bloque");
      }
      if (isblock == "Travesía") {
        isTrave = true;
        isBloque = false;
        fetchVias("quepared=" + version + "&isbloque=Travesía");
      }

      //list = raw!.values.where((item) => item.isbloque == isblock).toList();
      /*filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
          entry.value.isbloque == isblock &&
          entry.value.quepared == int.parse(version)));*/

      colorDificultad = Colors.transparent;
    }
  }

  void filtrarporBloque() {
    filterbyblock("nofilter");
    colorBbloque = t8_colorAccent;
    colorBtrave = t8_colorPrimary;
    notifyListeners();
  }

  void quitarFiltroBloqueTrave() {
    filterbyblock("Bloque");
    colorBbloque = t8_colorPrimary;
    colorBtrave = t8_colorPrimary;
    notifyListeners();
  }

  void filtrarporTravesia() {
    filterbyblock("Travesía");
    colorBtrave = t8_colorAccent;
    colorBbloque = t8_colorPrimary;
    notifyListeners();
  }

  void selectDevice(BuildContext context) async {
    selectedDevice = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SelectBondedDevicePage(checkAvailability: false);
        },
      ),
    );

    if (selectedDevice != null) {
      print('Connect -> selected ' + selectedDevice!.address);
    } else {
      print('Connect -> no device selected');
    }
    notifyListeners();
  }
}
