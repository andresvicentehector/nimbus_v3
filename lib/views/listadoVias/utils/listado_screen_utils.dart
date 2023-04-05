import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/template/colors/ColorsFixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nb_utils/nb_utils.dart';

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
              fontFamily: context.resources.fonts.tittle,
              fontSize: context.resources.dimensions.textSizeMedium),
        ),
      ),
      Text(
        viaData.autor,
        style: TextStyle(
          fontFamily: context.resources.fonts.fontBold,
        ),
      ),
      Text(
        viaData.presas.length.toString() +
            " " +
            context.resources.strings.homeScreenPresas,
        style: TextStyle(
          fontFamily: context.resources.fonts.fontBold,
        ),
      ),
    ],
  );
}

Widget botonCargarVia(
    BluetoothDevice? selectedDevice, BuildContext context, var viaData) {
  return Container(
      decoration: BoxDecoration(
          color: (Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(
                context.resources.strings.homeScreenLoadRoute +
                    " " +
                    (viaData.isbloque == 'Travesía'
                        ? (context.resources.strings
                                .addViaScreenDELATraveSelection +
                            " " +
                            context.resources.strings.addViaScreenTraveSelection
                                .toLowerCase())
                        : (context.resources.strings
                                .addViaScreenDELBloqueSelection +
                            " " +
                            context
                                .resources.strings.addViaScreenBloqueSelection
                                .toLowerCase())),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: context.resources.fonts.tittle,
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
                  Icons.arrow_forward,
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
                  hintText: context.resources.strings.homeScreenSearchNameAutor,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              onTap: () {
                _filterbyName(editingController, context);
              },
              onEditingComplete: () {
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
                    child: Text(
                        context.resources.strings.homeScreenBloque
                            .toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: context.resources.fonts.tittle,
                            fontSize:
                                context.resources.dimensions.textSizeMedium)),
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
                    child: Text(
                        context.resources.strings.homeScreenTravesia
                            .toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: context.resources.fonts.tittle,
                            fontSize:
                                context.resources.dimensions.textSizeMedium)),
                  ),
                ],
              )),
        ),
      )
    ]),
  ));
}
