import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../data/response/Status.dart';
import '../../escalarVia/escalar_screen.dart';
import '../../z_widgets_comunes/utils/LoadingWidget.dart';
import '../../z_widgets_comunes/utils/MyErrorWidget.dart';
import '../../z_widgets_comunes/utils/texto.dart';
import '../utils/listado_screen_utils.dart';

class BuilderListadoVias extends StatelessWidget {
  final List<Vias>? via;
  final dynamic status;
  final BluetoothDevice? selectedDevice;
  final String? message;
  const BuilderListadoVias(
      {required this.via,
      required this.selectedDevice,
      required this.status,
      required this.message});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.LOADING:
        print("ESTADO::LOADING");
        return LoadingWidget();
      case Status.ERROR:
        print("ESTADO :: ERROR LOADING");

        return MyErrorWidget(message ?? "NA");
      case Status.COMPLETED:
        //print("ESTADO :: COMPLETED");
        return Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 130.0, 6.0, 84.0),
            child: ListView.builder(
                reverse: false,
                itemCount: via!.length,
                //reverse: true,
                itemBuilder: (context, index) {
                  if (via!.isNotEmpty) {
                    var viaData = via![index];

                    return FadeInUp(
                      delay: Duration(milliseconds: 1),
                      child: InkWell(
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
                                            _escalarScreen(context, via![index],
                                                selectedDevice);
                                          }
                                        },
                                        child: circulo(viaData)),
                                    SizedBox(width: 14),
                                    GestureDetector(
                                        onTap: () {
                                          if (selectedDevice != null) {
                                            _escalarScreen(context, via![index],
                                                selectedDevice);
                                          }
                                        },
                                        child: textoDescriptivo(
                                            via![index], context)),
                                    SizedBox(width: 14),
                                  ],
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                    onTap: () {
                                      if (selectedDevice != null) {
                                        _escalarScreen(context, via![index],
                                            selectedDevice);
                                      }
                                    },
                                    child: botonCargarVia(
                                      selectedDevice,
                                      context,
                                    ))
                              ],
                            ),
                          )),
                    );
                  } else {
                    return Center(
                      child: texto("No hemos encontrado nada", context),
                    );
                  }
                }));
    }
    return Container();
  }

  void _escalarScreen(
      BuildContext context, Vias viaData, BluetoothDevice? selectedDevice) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EscalarScreen(
          via: viaData,
          server: selectedDevice,
        ),
      ),
    );
  }
}
