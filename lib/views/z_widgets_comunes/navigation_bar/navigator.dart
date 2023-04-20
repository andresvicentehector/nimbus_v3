import 'package:Nimbus/views/listadoVias/listado_screen.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/views/bluettothSetings/setings_screen.dart';
import 'package:Nimbus/views/addVia/addPresas_screen/add_presas_screen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Nimbus/views/escalarVia/escalar_screen.dart';
import 'package:Nimbus/views/juegos/jugar_screen.dart';

import 'package:Nimbus/template/images/T1Images.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../../template/colors/ColorsFixed.dart';
import '../../../template/configuration/ConstantesPropias.dart';

class Navigation extends StatefulWidget {
  final BluetoothDevice? selectedDevice;
  final pos;
  final Color colorBadd;

  const Navigation(
      {required this.selectedDevice,
      required this.pos,
      required this.colorBadd});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late var isSelected;
  Widget animation = Icon(
    Icons.add,
    color: t_white,
  );
  @override
  Widget build(BuildContext context) {
    isSelected = widget.pos;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 60,
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: shadowColorGlobal,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3.0))
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  tabItem(1, t1_home),
                  tabItem(2, t1_arrow_back),
                  Container(
                    width: 45,
                    height: 45,
                  ),
                  tabItem(3, t1_game),
                  tabItem(4, t1_settings)
                ],
              ),
            ),
          ),
          Container(
            height: 75,
            width: 75,
            child: FloatingActionButton(
                backgroundColor: widget.colorBadd,
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPresas(
                        server: widget.selectedDevice,
                      ),
                    ),
                  );
                },
                child: animation),
          )
        ],
      ),
    );
  }

  Widget tabItem(var pos, var icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = pos;
        });

        if (pos == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ListadoScreen(),
            ),
          );
        } else if (pos == 2) {
          if (indexData != null && widget.selectedDevice != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EscalarScreen(
                  server: widget.selectedDevice,
                  via: ViaData,
                ),
              ),
            );
          }
        } else if (pos == 3) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  JugarScreen(selectedDevice: widget.selectedDevice),
            ),
          );
        } else if (pos == 4) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  bluetooth_Screen(selectedDevice: widget.selectedDevice),
            ),
          );
        }
      },
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: isSelected == pos
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary)
            : BoxDecoration(),
        child: SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          color: isSelected == pos
              ? Theme.of(context).colorScheme.secondary
              : MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.black,
        ),
      ),
    );
  }
}
