import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/template/colors/ColorsFixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../../viewModels/ListadoVias/listado_VM.dart';

Widget circulo(var viaData) {
  return Container(
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: Color(viaData.dificultad)),
    width: 80,
    height: 80,
    padding: EdgeInsets.all(10),
  );
}

Widget textoDescriptivo(var viaData, BuildContext context) {
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
            fontFamily: 'ClashDisplay',
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: context.resources.dimensions.textSizeSMedium,
          ),
        ),
      ),
      Text(
        viaData.autor,
        style: TextStyle(
          fontFamily: context.resources.dimensions.fontBold,
        ),
      ),
      Text(
        viaData.presas.length.toString() + " presas",
        style: TextStyle(
          fontFamily: context.resources.dimensions.fontBold,
        ),
      ),
    ],
  );
}

Widget botonCargarVia(BluetoothDevice? selectedDevice, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: (selectedDevice != null
              ? Theme.of(context).colorScheme.primary
              : t_unactive),
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
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'ClashDisplay',
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
                  color: Theme.of(context).colorScheme.tertiary,
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
    BuildContext context,
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
                _filterbyName(editingController, context);
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
            _quitarFiltroBloqueTrave(context);
          },
        ),
      ),
    ],
  );
}

Widget botoneraBloqueVia(ViasListVM viewModel, BuildContext context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 5.0),
    child: Row(children: [
      Expanded(
        flex: 5,
        child: GestureDetector(
          onTap: () {
            viewModel.filtrarporBloque(context);
          },
          onDoubleTap: () {
            viewModel.quitarFiltroBloqueTrave(context);
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
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: 'ClashDisplay',
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
            viewModel.filtrarporTravesia(context);
          },
          onDoubleTap: () {
            viewModel.quitarFiltroBloqueTrave(context);
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
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: 'ClashDisplay',
                        )),
                  ),
                ],
              )),
        ),
      )
    ]),
  ));
}
