import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../screens/escalar_screen.dart';
import '../../template/T8Colors.dart';
import '../../template/T8Constant.dart';
import 'texto.dart';

Widget circulo(var viaData) {
  return Container(
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: Color(viaData.dificultad)),
    width: 80,
    height: 80,
    padding: EdgeInsets.all(10),
  );
}

Widget textoDescriptivo(var viaData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(viaData.name,
          style: TextStyle(
              color: t8_textColorSecondary, fontSize: textSizeSMedium)),
      Text(viaData.autor, style: TextStyle(fontFamily: fontMedium)),
      Text(viaData.presas.length.toString() + " presas",
          style: TextStyle(fontFamily: fontMedium)),
    ],
  );
}

Widget botonCargarVia(BluetoothDevice? selectedDevice) {
  return Container(
      decoration: BoxDecoration(
          color: (selectedDevice != null
              ? t8_colorPrimary
              : t8_textColorSecondary),
          borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(
                (selectedDevice != null
                    ? "Cargar vía"
                    : "Conéctate a la pared"),
                style: TextStyle(
                  color: t8_white,
                  fontFamily: 'November',
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 35,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  selectedDevice != null
                      ? Icons.arrow_forward
                      : Icons.arrow_upward,
                  color: t8_white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ));
}

Widget botonerafiltrosSearchColor(
    TextEditingController editingController,
    Function _filterbyName,
    Color colorDificultad,
    _key,
    Function _filterbyblock,
    Color colorBbloque,
    Color colorBtrave,
    bool isTrave,
    bool isBloque) {
  return Row(
    children: [
      Expanded(
        flex: 9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 6.0, 2.0, 6.0),
          child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  hintText: "Busca por nombre o autor",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              onTap: () {
                _filterbyName(editingController);
              }),
        ),
      ),
      Expanded(
        flex: 1,
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorDificultad,
                border: Border.all(color: Colors.grey)),
            width: 60,
            padding: EdgeInsets.all(20),
          ),
          onTap: () {
            _key.currentState?.openDrawer();
          },
          onDoubleTap: () {
            _filterbyblock('nofilter');
            colorBbloque = t8_colorPrimary;
            colorBtrave = t8_colorPrimary;
            isTrave = false;
            isBloque = false;
          },
        ),
      ),
    ],
  );
}

Widget builderListadoVias(Box itemBox, Map<dynamic, dynamic>? raw,
    Map<dynamic, dynamic>? filteredraw, BluetoothDevice? selectedDevice) {
  void _escalarScreen(BuildContext context, var viaData, int key,
      BluetoothDevice? selectedDevice) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EscalarScreen(
          xKey: key,
          via: viaData,
          server: selectedDevice,
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(6.0, 130.0, 6.0, 84.0),
    child: ValueListenableBuilder(
      valueListenable: itemBox.listenable(),
      builder: (
        context,
        Box box,
        widget,
      ) {
        if (box.isEmpty) {
          return Center(
            child: texto("Crea una nueva vía"),
          );
        } else if (filteredraw!.isNotEmpty) {
          return ListView.builder(
            reverse: false,
            itemCount: filteredraw.length,
            //reverse: true,
            itemBuilder: (context, index) {
              int key =
                  filteredraw.keys.elementAt(filteredraw.length - 1 - index);
              var viaData = filteredraw[key];
              //print(filteredraw.keys.toString());
              //print("index: $index");
              //print("Key: $key");

              return InkWell(
                  borderRadius: BorderRadius.all(Radius.zero),
                  radius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  if (selectedDevice != null) {
                                    _escalarScreen(
                                        context, viaData, key, selectedDevice);
                                  }
                                },
                                child: circulo(viaData)),
                            SizedBox(width: 14),
                            GestureDetector(
                                onTap: () {
                                  if (selectedDevice != null) {
                                    _escalarScreen(
                                        context, viaData, key, selectedDevice);
                                  }
                                },
                                child: textoDescriptivo(viaData)),
                            SizedBox(width: 14),
                          ],
                        ),
                        SizedBox(height: 14),
                        GestureDetector(
                          onTap: () {
                            if (selectedDevice != null) {
                              _escalarScreen(
                                  context, viaData, key, selectedDevice);
                            }
                          },
                          child: botonCargarVia(selectedDevice),
                        )
                      ],
                    ),
                  ));
            },
          );
        } else {
          return Center(
            child: texto("No hemos encontrado nada"),
          );
        }
      },
    ),
  );
}
