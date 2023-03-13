import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../functions/navigator_MaterialPage_functions.dart';
import '../../template/T8Colors.dart';
import '../../template/T8Constant.dart';
import '../bluetooth/SelectBondedDevicePage.dart';

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
                  Text("Modo-Dictado",
                      style: TextStyle(fontSize: textSizeSMedium)),
                  Text("2+2", style: TextStyle(fontFamily: fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                    "Selecciona la presa que quieres que se ilumine en la tablet para que la persona que esté escalando pueda alcanzarla",
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
                  color: t8_colorPrimary,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Iniciar",
                        style: TextStyle(
                          color: t8_white,
                          fontFamily: "November",
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
                          color: t8_white,
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
                  Text("Raulin-stones",
                      style: TextStyle(fontSize: textSizeSMedium)),
                  Text(" 2 menos 2", style: TextStyle(fontFamily: fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  "Juega con un compañero o compañera.\nEmpezad eligiendo en la tablet las presas de inicio y las del top. Escala desde el start hasta el top mientras tu compañero marca las presas que estas utilizando.\nEn la siguiente ronda tu compañero o compañera tendrá que llegar al top sin utilizar las presas que están marcadas. El que primero cae PIERDE! \nManten pulsado para seleccionar las presas de inicio/top (Se mostrarán en blanco). Pulsa una vez sobre las presas que quieras marcar (Se mostrarán en rojo). Pulsa dos veces sobre la presa para apagarla.",
                ),
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
                  color: t8_colorPrimary,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Iniciar",
                        style: TextStyle(
                          color: t8_white,
                          fontFamily: "November",
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
                          color: t8_white,
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
                  Text("Kimo-Game",
                      style: TextStyle(fontSize: textSizeSMedium)),
                  Text("Kimo", style: TextStyle(fontFamily: fontMedium)),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                    "Llega a la siguiente presa antes de que se acabe el tiempo. Este juego fue diseñado para la pared de 25 grados, así que debes conectarte a ella para poder jugar",
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
                  color: t8_colorPrimary,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Jugar",
                        style: TextStyle(
                          color: t8_white,
                          fontFamily: "November",
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
                          color: t8_white,
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
