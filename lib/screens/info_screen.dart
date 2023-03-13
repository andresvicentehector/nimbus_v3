import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:Nimbus/widgets/bluetooth/SelectBondedDevicePage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Nimbus/template/T8Colors.dart';
import 'package:Nimbus/template/ConstantesPropias.dart';
import 'package:Nimbus/widgets/navigation_bar/navigator.dart';
import '../widgets/utils/texto.dart';
import '../widgets/utils/info_screen_utils.dart';
import '../widgets/navigation_bar/sidebarX.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Box itemBox = Hive.box("Viabox");
  late BluetoothDevice? selectedDevice;
  late List list, list2;
  late Map<dynamic, dynamic>? raw = Map.fromEntries(itemBox
      .toMap()
      .entries
      .where((entry) => entry.value.quepared == int.parse(version)));
  late Map<dynamic, dynamic>? filteredraw = Map.fromEntries(itemBox
      .toMap()
      .entries
      .where((entry) => entry.value.quepared == int.parse(version)));
  late var width = 50.0;
  late Color selectedColor;
  late TextEditingController editingController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  late Color colorBtrave = t8_colorPrimary;
  late Color colorBbloque = t8_colorPrimary;
  late Color colorDificultad;
  late bool isBloque = false;
  late bool isTrave = false;

  @override
  void initState() {
    super.initState();

    list = raw!.values.toList();
    list2 = raw!.keys.toList();

    filteredraw = raw;
    selectedDevice = null;
    colorDificultad = Colors.transparent;
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: SideBarX(
          controller: _controller,
          filtrofunction: _filterbylevel,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: texto(quePared),
          actions: <Widget>[
            ElevatedButton(
              child: Icon(Icons.bluetooth,
                  color: selectedDevice != null ? Colors.blue : Colors.white),
              onPressed: () async {
                selectedDevice = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectBondedDevicePage(checkAvailability: false);
                    },
                  ),
                );

                if (selectedDevice != null) {
                  //print('Connect -> selected ' + selectedDevice!.address);
                  setState(() {});
                } else {
                  //print('Connect -> no device selected');
                }
              },
            ),
          ],
        ),
        body: Stack(children: [
          Column(
            children: [
              botonerafiltrosSearchColor(
                  editingController,
                  _filterbyName,
                  colorDificultad,
                  _key,
                  _filterbyblock,
                  colorBbloque,
                  colorBtrave,
                  isTrave,
                  isBloque),
              _botoneraBloqueVia(),
            ],
          ),
          builderListadoVias(itemBox, raw, filteredraw, selectedDevice),
          Navigation(selectedDevice: selectedDevice),
        ]));
  }

  Widget _botoneraBloqueVia() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 5.0),
      child: Row(children: [
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              _filterbyblock("Bloque");

              colorBbloque = t8_colorAccent;
              colorBtrave = t8_colorPrimary;
            },
            onDoubleTap: () {
              _filterbyblock("nofilter");
              colorBbloque = t8_colorPrimary;
              colorBtrave = t8_colorPrimary;
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: colorBbloque,
                  border: Border.all(color: Color(0xFFFFF)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("Bloques",
                          style: TextStyle(
                            color: t8_white,
                            fontFamily: 'November',
                          )),
                    ),
                  ],
                )),
          ),
        ),
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              _filterbyblock("Travesía");

              colorBtrave = t8_colorAccent;
              colorBbloque = t8_colorPrimary;
            },
            onDoubleTap: () {
              _filterbyblock("nofilter");
              colorBtrave = t8_colorPrimary;
              colorBbloque = t8_colorPrimary;
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: colorBtrave,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("Travesías",
                          style: TextStyle(
                            color: t8_white,
                            fontFamily: 'November',
                          )),
                    ),
                  ],
                )),
          ),
        )
      ]),
    ));
  }

  void _filterbyName(TextEditingController _searchController) {
    if (_searchController.text == "") {
      list = raw!.values.toList();
      filteredraw = raw;
      colorBbloque = t8_colorPrimary;
      colorBtrave = t8_colorPrimary;
      colorDificultad = Colors.transparent;
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
          .toList();*/

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
          entry.value.quepared == int.parse(version)));

      colorBbloque = t8_colorPrimary;
      colorBtrave = t8_colorPrimary;
      colorDificultad = Colors.transparent;
    }

    setState(() {
      isBloque = false;
      isTrave = false;
    });
  }

  void _filterbylevel(int color) {
    setState(() {
      if (isBloque == false && isTrave == false) {
        if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
          /* list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value))
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.pinkAccent.value ||
                  entry.value.dificultad == Colors.pink.value) &&
              entry.value.quepared == int.parse(version)));

          colorDificultad = Colors.pink;
        } else if (color == Colors.orangeAccent.value ||
            color == Colors.orange.value) {
          /* list = raw!.values
              .where((item) =>
                  item.dificultad == Colors.orange.value ||
                  item.dificultad == Colors.orangeAccent.value)
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.orange.value ||
                  entry.value.dificultad == Colors.orangeAccent.value) &&
              entry.value.quepared == int.parse(version)));

          colorDificultad = Colors.orange;
        } else {
          //list = raw!.values.where((item) => item.dificultad == color).toList();

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              entry.value.dificultad == color &&
              entry.value.quepared == int.parse(version)));

          colorDificultad = Color(color);
        }
      }

      if (isBloque == true) {
        if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
          /* list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value) &&
                  element.isbloque == "Bloque")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.pinkAccent.value ||
                  entry.value.dificultad == Colors.pink.value) &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Bloque"));

          colorDificultad = Colors.pink;
        } else if (color == Colors.orangeAccent.value ||
            color == Colors.orange.value) {
          /*list = raw!.values
              .where((item) =>
                  (item.dificultad == Colors.orange.value ||
                      item.dificultad == Colors.orangeAccent.value) &&
                  item.isbloque == "Bloque")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.orange.value ||
                  entry.value.dificultad == Colors.orangeAccent.value) &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Bloque"));

          colorDificultad = Colors.orange;
        } else {
          /*list = raw!.values
              .where((item) =>
                  item.dificultad == color && item.isbloque == "Bloque")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              entry.value.dificultad == color &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Bloque"));

          colorDificultad = Color(color);
        }
      }

      if (isTrave == true) {
        if (color == Colors.pinkAccent.value || color == Colors.pink.value) {
          /*list = raw!.values
              .where((element) =>
                  (element.dificultad == Colors.pinkAccent.value ||
                      element.dificultad == Colors.pink.value) &&
                  element.isbloque == "Travesía")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.pinkAccent.value ||
                  entry.value.dificultad == Colors.pink.value) &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Travesía"));

          colorDificultad = Colors.pink;
        } else if (color == Colors.orangeAccent.value ||
            color == Colors.orange.value) {
          /*  list = raw!.values
              .where((item) =>
                  (item.dificultad == Colors.orange.value ||
                      item.dificultad == Colors.orangeAccent.value) &&
                  item.isbloque == "Travesía")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              (entry.value.dificultad == Colors.orange.value ||
                  entry.value.dificultad == Colors.orangeAccent.value) &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Travesía"));

          colorDificultad = Colors.orange;
        } else {
          /*list = raw!.values
              .where((item) =>
                  item.dificultad == color && item.isbloque == "Travesía")
              .toList();*/

          filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
              entry.value.dificultad == color &&
              entry.value.quepared == int.parse(version) &&
              entry.value.isbloque == "Travesía"));

          colorDificultad = Color(color);
        }
      }
    });
    editingController.text = "";
  }

  void _filterbyblock(String isblock) {
    setState(() {
      editingController.text = "";
      if (isblock == "nofilter") {
        list = raw!.values.toList();
        setState(() {
          filteredraw = raw;
          colorDificultad = Colors.transparent;
          isBloque = false;
          isTrave = false;
        });
      } else {
        if (isblock == "Bloque") {
          setState(() {
            isBloque = true;
            isTrave = false;
          });
        }
        if (isblock == "Travesía") {
          setState(() {
            isTrave = true;
            isBloque = false;
          });
        }

        //list = raw!.values.where((item) => item.isbloque == isblock).toList();
        filteredraw = Map.fromEntries(raw!.entries.where((entry) =>
            entry.value.isbloque == isblock &&
            entry.value.quepared == int.parse(version)));
        setState(() {
          colorDificultad = Colors.transparent;
        });
      }
    });
  }
}
