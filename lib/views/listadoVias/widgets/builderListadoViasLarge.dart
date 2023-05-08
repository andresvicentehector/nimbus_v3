import 'package:Nimbus/models/ListadoVias/AWS/ViaAWS.dart';
import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../../../data/response/Status.dart';
import '../../escalarVia/escalar_screen.dart';
import '../../z_widgets_comunes/utils/LoadingWidget.dart';
import '../../z_widgets_comunes/utils/MyErrorWidget.dart';
import '../../z_widgets_comunes/utils/texto.dart';
import '../utils/listado_screen_utils.dart';

class BuilderListadoViasLarge extends StatelessWidget {
  final List<Vias>? via;
  final dynamic status;
  final BluetoothDevice? selectedDevice;
  final String? message;
  const BuilderListadoViasLarge(
      {required this.via,
      required this.selectedDevice,
      required this.status,
      required this.message});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.LOADING:
        //print("ESTADO::LOADING");
        return LoadingWidget();
      case Status.ERROR:
        //print("ESTADO :: ERROR LOADING");
        return Column(
          children: [
            MyErrorWidget(message ?? "NA"),
          ],
        );
      case Status.COMPLETED:
        //print("ESTADO :: COMPLETED");
        return Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 125.0, 6.0, 60.0),
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              childAspectRatio:
                  MediaQuery.of(context).size.width <= 1200 ? 1.8 : 3.7,
            ),
            itemCount: via!.length,
            itemBuilder: (context, index) {
              if (via!.isNotEmpty) {
                var viaData = via![via!.length - index - 1];

                return FadeInUp(
                  delay: Duration(milliseconds: 1),
                  child: InkWell(
                    onTap: () => {
                      if (true)
                        {
                          _escalarScreen(
                            context,
                            via![via!.length - index - 1],
                            selectedDevice,
                          )
                        }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Color.fromARGB(255, 22, 22, 22)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? [
                                  Color.fromARGB(255, 117, 70, 226),
                                  Color.fromARGB(255, 203, 194, 240),
                                ]
                              : [
                                  Color.fromARGB(255, 56, 52, 68),
                                  Color.fromARGB(224, 48, 46, 59),
                                ],
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 15.0, 10, 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (selectedDevice != null) {
                                      _escalarScreen(
                                        context,
                                        via![via!.length - index - 1],
                                        selectedDevice,
                                      );
                                    }
                                  },
                                  child: circulo(viaData),
                                ),
                                SizedBox(width: 14),
                                GestureDetector(
                                  onTap: () {
                                    if (selectedDevice != null) {
                                      _escalarScreen(
                                        context,
                                        via![via!.length - index - 1],
                                        selectedDevice,
                                      );
                                    }
                                  },
                                  child: textoDescriptivo(
                                    via![via!.length - index - 1],
                                    context,
                                  ),
                                ),
                                // SizedBox(width: 14),
                              ],
                            ),
                            SizedBox(height: 14),
                            GestureDetector(
                              onTap: () {
                                if (true) {
                                  _escalarScreen(
                                    context,
                                    via![via!.length - index - 1],
                                    selectedDevice,
                                  );
                                }
                              },
                              child: botonCargarVia(
                                selectedDevice,
                                context,
                                via![via!.length - index - 1],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: texto(
                    context.resources.strings.homeScreenNothingFound,
                    context,
                  ),
                );
              }
            },
          ),
        );
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
