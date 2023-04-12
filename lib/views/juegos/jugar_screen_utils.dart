import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../viewModels/juegos/navigator_MaterialPage_functions.dart';
import '../bluettothSetings/widgets/SelectBondedDevicePage.dart';

Widget dictadoInfo(BuildContext context) {
  return InkWell(
      child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
          width: 500,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(context.resources.strings.juegosScreenDictado,
                      style: TextStyle(
                          fontSize:
                              context.resources.dimensions.textSizeSMedium,
                          fontFamily: context.resources.fonts.tittle)),
                  Text(
                      context.resources.strings
                          .juegosScreenDictadoDescriptionShort,
                      style: TextStyle(
                          fontFamily: context.resources.fonts.fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                    context.resources.strings.juegosScreenDictadoDescription,
                    maxLines: 4),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        GestureDetector(
          onTap: () async {
            final BluetoothDevice? selectedDevice =
                await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SelectBondedDevicePage(checkAvailability: false);
                },
              ),
            );
            if (selectedDevice != null) {
              startDictado(context, selectedDevice);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(17.0)),
              padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text(context.resources.strings.juegosScreenBegin,
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
              )),
        )
      ],
    ),
  ));
}

Widget raulinInfo(BuildContext context) {
  return InkWell(
      child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 250,
          width: 500,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(context.resources.strings.juegosScreenRaulin,
                      style: TextStyle(
                          fontSize:
                              context.resources.dimensions.textSizeSMedium,
                          fontFamily: context.resources.fonts.tittle)),
                  Text(
                      context
                          .resources.strings.juegosScreenRaulinDescriptionShort,
                      style: TextStyle(
                          fontFamily: context.resources.fonts.fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                    context.resources.strings.juegosScreenRaulinDescription),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        GestureDetector(
          onTap: () async {
            final BluetoothDevice? selectedDevice =
                await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SelectBondedDevicePage(checkAvailability: false);
                },
              ),
            );
            if (selectedDevice != null) {
              startRaulin(context, selectedDevice);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(17.0)),
              padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text(context.resources.strings.juegosScreenBegin,
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
              )),
        )
      ],
    ),
  ));
}

Widget kimoInfo(BuildContext context) {
  return InkWell(
      child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
          width: 500,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(context.resources.strings.juegosScreenKimo,
                      style: TextStyle(
                          fontSize:
                              context.resources.dimensions.textSizeSMedium,
                          fontFamily: context.resources.fonts.tittle)),
                  Text(
                      context
                          .resources.strings.juegosScreenKimoDescriptionShort,
                      style: TextStyle(
                          fontFamily: context.resources.fonts.fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                    context.resources.strings.juegosScreenKimoDescription,
                    maxLines: 4),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        GestureDetector(
          onTap: () async {
            final BluetoothDevice? selectedDevice =
                await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SelectBondedDevicePage(checkAvailability: false);
                },
              ),
            );
            if (selectedDevice != null) {
              startChatKimo(context, selectedDevice);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(17)),
              padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text(context.resources.strings.juegosScreenBegin,
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
              )),
        )
      ],
    ),
  ));
}
