import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/response/Status.dart';
import '../../../viewModels/ListadoVias/listado_VM.dart';
import '../../escalarVia/escalar_screen.dart';
import '../../z_widgets_comunes/utils/texto.dart';
import '../utils/listado_screen_utils.dart';

Widget builderListadoVias(
    Box itemBox,
    Map<dynamic, dynamic>? raw,
    Map<dynamic, dynamic>? filteredraw,
    BluetoothDevice? selectedDevice,
    ViasListVM viewModel) {
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

  switch (viewModel.ViasMain.status) {
    case Status.LOADING:
      print("ESTADO::LOADING");
      // return LoadingWidget();
      return Container();
    case Status.ERROR:
      print("ESTADO :: ERROR LOADING");
      return Container();
    // return MyErrorWidget(viewModel.viasMain.message ?? "NA");
    case Status.COMPLETED:
      //print("ESTADO :: COMPLETED");
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
                  int key = filteredraw.keys
                      .elementAt(filteredraw.length - 1 - index);
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
                                        _escalarScreen(context, viaData, key,
                                            selectedDevice);
                                      }
                                    },
                                    child: circulo(viaData)),
                                SizedBox(width: 14),
                                GestureDetector(
                                    onTap: () {
                                      if (selectedDevice != null) {
                                        _escalarScreen(context, viaData, key,
                                            selectedDevice);
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
  return Container();
}
