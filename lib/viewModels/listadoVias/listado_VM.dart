//import 'package:Hector_Show_data/remote/network/ApiEndPoints.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../data/response/ApiResponse.dart';
import '../../models/ListadoVias/hive/via.dart';
import '../../repository/vias/ViaRepoImp.dart';
import '../../template/colors/ColorsFixed.dart';
import '../../template/configuration/ConstantesPropias.dart';
import '../../views/bluettothSetings/widgets/SelectBondedDevicePage.dart';

class ViasListVM extends ChangeNotifier {
  //Internal and private State of movie
  final _myRepo = ViaRepoImp();

  ApiResponse<ViaAWS> viasMain = ApiResponse.loading();

  late List<dynamic> viasMainHive = [];

  // late List<Results>? movieMainHive;
  //utilizaremos estas tres más tarde para los idiomas
  String page = "1";
  String lang = "en-US";
  String flagUrl = "assets/images/flags/usa.png";

  late TextEditingController editingController = TextEditingController();

  final controllerSideBar =
      SidebarXController(selectedIndex: 0, extended: true);

  // ignore: avoid_init_to_null
  BluetoothDevice? selectedDevice = null;

  late Color colorBtrave = t_primary;
  late Color colorBbloque = t_primary;

  late Box itemBox = Hive.box("Viabox");

  late Color colorDificultad = Colors.transparent;

  late Color colorBAdd = t_primary;

  late bool isBloque = false;
  late bool isTrave = false;

  bool? get isOnline => true;

  void checkIfDataConnection() async {
    if (!kIsWeb) {
      if (await InternetConnectionChecker().hasConnection) {
        fetchVias("listar?quepared=" + version);
        compareAWSwithHive();
      } else {
        print('No hay conexión de datos');
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        fetchViasFromHive(version);
        notifyListeners();
      }
    } else {
      if (isOnline == true) {
        fetchVias("listar?quepared=" + version);
        compareAWSwithHive();
      } else {
        print('No hay conexión de datos');
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        fetchViasFromHive(version);
        notifyListeners();
      }
    }
  }

//el parametro de entrada es la clase api response que coje la clase movie como parametro de entrada y devuelve una respuesta
  void _setViasMain(ApiResponse<ViaAWS> response) {
    //print("Response :: $response");
    viasMain = response;
    notifyListeners();
  }

  void _setViasMainHive(String version) {
    //print(" :: $response");
    viasMainHive =
        itemBox.values.where((item) => item.quepared == version).toList();
  }

  void compareAWSwithHive() async {
    if (!kIsWeb) {
      if (await InternetConnectionChecker().hasConnection) {
        if (viasMain.data?.vias?.length != viasMainHive.length) {
          makeaCopy();
        }
      } else {
        print('Comparación FAILED');
      }
    } else {
      if (isOnline == true) {
        if (viasMain.data?.vias?.length != viasMainHive.length) {
          makeaCopy();
        }
      } else {
        print('Comparación FAILED');
      }
    }
  }

//the only way to access to movie list from the ui
  Future<void> fetchVias(String query) async {
    print("query " + query);

    if (!kIsWeb) {
      if (await InternetConnectionChecker().hasConnection) {
        _setViasMain(ApiResponse.loading());

        _myRepo
            .getViasList(query)
            .then((value) => _setViasMain(ApiResponse.completed(value)))
            .onError((error, stackTrace) =>
                _setViasMain(ApiResponse.error(error.toString())));
      } else {
        print('No hay conexión de datos');
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        fetchViasFromHive(version);
        notifyListeners();
      }
    } else {
      if (isOnline == true) {
        _setViasMain(ApiResponse.loading());

        _myRepo
            .getViasList(query)
            .then((value) => _setViasMain(ApiResponse.completed(value)))
            .onError((error, stackTrace) =>
                _setViasMain(ApiResponse.error(error.toString())));
      } else {
        print('No hay conexión de datos');
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        fetchViasFromHive(version);
        notifyListeners();
      }
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

  void filterbyName(
      TextEditingController _searchController, BuildContext context) async {
    if (!kIsWeb) {
      //check if there is connection
      if (await InternetConnectionChecker().hasConnection) {
        if (_searchController.text == "") {
          fetchVias("listar?quepared=" + version);
          notifyListeners();
        } else {
          fetchVias(
              "buscar?buscar=${_searchController.text}&quepared=" + version);
          print(version + "/${_searchController.text}");
          notifyListeners();
        }

        isBloque = false;
        isTrave = false;
        colorBbloque = Theme.of(context).colorScheme.primary;
        colorBtrave = Theme.of(context).colorScheme.primary;
        colorDificultad = Colors.transparent;
      } else {
        //TODO: Poder filtrar por nombre en hive(ya estaba hecho tilín)
        isBloque = false;
        isTrave = false;
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        colorBAdd = t_unactive;
      }
    } else {
      if (isOnline == true) {
        if (_searchController.text == "") {
          fetchVias("listar?quepared=" + version);
          notifyListeners();
        } else {
          fetchVias(
              "buscar?buscar=${_searchController.text}&quepared=" + version);
          print(version + "/${_searchController.text}");
          notifyListeners();
        }

        isBloque = false;
        isTrave = false;
        colorBbloque = Theme.of(context).colorScheme.primary;
        colorBtrave = Theme.of(context).colorScheme.primary;
        colorDificultad = Colors.transparent;
      } else {
        //TODO: Poder filtrar por nombre en hive(ya estaba hecho tilín)
        isBloque = false;
        isTrave = false;
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        colorBAdd = t_unactive;
      }
    }
  }

  void filterbylevel(int color) async {
    //si no esta seleccionado el filtro de bloque o trave
    if (!kIsWeb) {
//check if there is connection
      if (await InternetConnectionChecker().hasConnection) {
        if (isBloque == false && isTrave == false) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            fetchVias("listar?quepared=" + version + "&dificultad=morado");
            colorDificultad = Colors.pink;
            notifyListeners();
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" + version + "&dificultad=naranja");
          } else if (color == Colors.green.value) {
            fetchVias("listar?quepared=" + version + "&dificultad=verde");
            colorDificultad = Colors.green;
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" + version + "&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" + version + "&dificultad=negro");
          }
        }

        //si está seleccionado el bloque
        if (isBloque == true) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            colorDificultad = Colors.pink;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=morado");
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=naranja");
          } else if (color == Colors.green.value) {
            colorDificultad = Colors.green;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=verde");
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=negro");
          }
        }

        //si está seleccionada la trave
        if (isTrave == true) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            colorDificultad = Colors.pink;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=morado");
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=naranja");
          } else if (color == Colors.green.value) {
            colorDificultad = Colors.green;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=verde");
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=negro");
          }
        }

        editingController.text = "";
        notifyListeners();
      } else {
        //TODO: Poder filtrar por  dificultad en hive(ya estaba hecho tilín)
        isBloque = false;
        isTrave = false;
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        colorBAdd = t_unactive;
      }
    } else {
      if (isOnline == true) {
        if (isBloque == false && isTrave == false) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            fetchVias("listar?quepared=" + version + "&dificultad=morado");
            colorDificultad = Colors.pink;
            notifyListeners();
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" + version + "&dificultad=naranja");
          } else if (color == Colors.green.value) {
            fetchVias("listar?quepared=" + version + "&dificultad=verde");
            colorDificultad = Colors.green;
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" + version + "&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" + version + "&dificultad=negro");
          }
        }

        //si está seleccionado el bloque
        if (isBloque == true) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            colorDificultad = Colors.pink;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=morado");
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=naranja");
          } else if (color == Colors.green.value) {
            colorDificultad = Colors.green;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=verde");
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Bloque&dificultad=negro");
          }
        }

        //si está seleccionada la trave
        if (isTrave == true) {
          if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
            colorDificultad = Colors.pink;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=morado");
          } else if (color == Colors.orangeAccent.value ||
              color == Colors.orange.value) {
            colorDificultad = Colors.orange;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=naranja");
          } else if (color == Colors.green.value) {
            colorDificultad = Colors.green;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=verde");
          } else if (color == Colors.yellow.value) {
            colorDificultad = Colors.yellow;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=amarillo");
          } else if (color == Colors.black.value) {
            colorDificultad = Colors.black;
            fetchVias("listar?quepared=" +
                version +
                "&isbloque=Travesía&dificultad=negro");
          }
        }

        editingController.text = "";
        notifyListeners();
      } else {
        //TODO: Poder filtrar por  dificultad en hive(ya estaba hecho tilín)
        isBloque = false;
        isTrave = false;
        colorBbloque = t_unactive;
        colorBtrave = t_unactive;
        colorDificultad = t_unactive;
        colorBAdd = t_unactive;
      }
    }
  }

  void filterbyblock(String isblock) {
    editingController.text = "";
    if (isblock == "nofilter") {
      colorDificultad = Colors.transparent;
      isBloque = false;
      isTrave = false;
      fetchVias("listar?quepared=" + version);
    } else {
      if (isblock == "Bloque") {
        isBloque = true;
        isTrave = false;
        fetchVias("listar?quepared=" + version + "&isbloque=Bloque");
      }
      if (isblock == "Travesía") {
        isTrave = true;
        isBloque = false;
        fetchVias("listar?quepared=" + version + "&isbloque=Travesía");
      }

      colorDificultad = Colors.transparent;
    }
  }

  void filtrarporBloque(BuildContext context) {
    filterbyblock("Bloque");
    colorBbloque = Theme.of(context).colorScheme.secondary;
    colorBtrave = Theme.of(context).colorScheme.primary;

    notifyListeners();
  }

  void filtrarporTravesia(BuildContext context) {
    filterbyblock("Travesía");
    colorBtrave = Theme.of(context).colorScheme.secondary;
    colorBbloque = Theme.of(context).colorScheme.primary;
    notifyListeners();
  }

  void quitarFiltroBloqueTrave(BuildContext context) {
    filterbyblock("nofilter");
    colorBbloque = Theme.of(context).colorScheme.primary;
    colorBtrave = Theme.of(context).colorScheme.primary;
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

  void makeaCopy() async {
    print('Making a coppy');
    // await Delete BBDD
    //make a loop till all viaAWS length and coppy d
  }

  Future<void> fetchViasFromHive(String version) async {
    _setViasMainHive(version);
  }
}
