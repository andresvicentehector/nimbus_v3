import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:Nimbus/template/T8Colors.dart';

// ignore: must_be_immutable
class SideBarX extends StatelessWidget {
  final SidebarXController _controller;
  final Function filtrofunction;

  SideBarX(
      {Key? key,
      required SidebarXController controller,
      required this.filtrofunction})
      : _controller = controller;

  late var width = 100;

  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    const canvasColor = t8_colorPrimary;
    const scaffoldBackgroundColor = t8_colorPrimary;
    const accentCanvasColor = t8_colorPrimary;
    const white = Colors.white;
    final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
    final divider = Divider(color: white.withOpacity(0.3), height: 1);

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: circulo(color.value),
          ),
        );
      },
      items: [
        SidebarXItem(
            iconWidget: icono(Colors.black),
            label: 'Insanos',
            onTap: () {
              color = Colors.black;
              filtrofunction(Colors.black.value);
            }),
        SidebarXItem(
            iconWidget: icono(Colors.pink),
            label: 'Difíciles',
            onTap: () {
              color = Colors.pink;
              filtrofunction(Colors.pink.value);
            }),
        SidebarXItem(
            iconWidget: icono(Colors.orange),
            label: 'Avanzados',
            onTap: () {
              color = Colors.orange;
              filtrofunction(Colors.orange.value);
            }),
        SidebarXItem(
            iconWidget: icono(Colors.yellow),
            label: 'Intermedios',
            onTap: () {
              color = Colors.yellow;
              filtrofunction(Colors.yellow.value);
            }),
        SidebarXItem(
            iconWidget: icono(Colors.green),
            label: 'Iniciados',
            onTap: () {
              color = Colors.green;
              filtrofunction(Colors.green.value);
            }),
      ],
    );
  }

  Widget icono(Color colorear) {
    return Icon(Icons.circle, color: colorear);
  }

  Widget circulo(int colorcirculo) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(colorcirculo)),
      width: width / 2,
      height: width / 2,
      padding: EdgeInsets.all(10),
    );
  }
}
