import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../../viewModels/ListadoVias/listado_VM.dart';
import '/template/T8Colors.dart';
import '/template/T8Constant.dart';

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
      SizedBox(
        width: 270,
        child: Text(
          viaData.name,
          maxLines: 4,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: t8_textColorSecondary,
            fontSize: textSizeSMedium,
          ),
        ),
      ),
      Text(
        viaData.autor,
        style: TextStyle(
          fontFamily: fontMedium,
        ),
      ),
      Text(
        viaData.presas.length.toString() + " presas",
        style: TextStyle(
          fontFamily: fontMedium,
        ),
      ),
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
    Function _quitarFiltroBloqueTrave,
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
            _quitarFiltroBloqueTrave();
          },
        ),
      ),
    ],
  );
}

Widget botoneraBloqueVia(ViasListVM viewModel) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 5.0),
    child: Row(children: [
      Expanded(
        flex: 5,
        child: GestureDetector(
          onTap: () {
            viewModel.filtrarporBloque();
          },
          onDoubleTap: () {
            viewModel.quitarFiltroBloqueTrave();
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: viewModel.colorBbloque,
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
            viewModel.filtrarporTravesia();
          },
          onDoubleTap: () {
            viewModel.quitarFiltroBloqueTrave();
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: viewModel.colorBtrave,
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
