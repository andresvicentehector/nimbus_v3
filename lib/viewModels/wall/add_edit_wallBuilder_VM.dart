import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class AddEditWallVM extends ChangeNotifier {
  bool isActivated = false;
  late bool marcar = false;
  late int colorController;
  late Color c1;
  late Color c3 = Color.fromARGB(193, 126, 124, 124);
  late Color c2 = Colors.transparent;
  final LayerLink layerLink = LayerLink();
  late Widget overlayContent;
  late AnimationController controller;
  OverlayEntry? overlayEntry;
  bool isOpen = false;

  bool changeActive = false;
  late var val2;

  late String changeController;
  late List<Map<String, dynamic>> _items = [];

  itemsfunc(List<String> presas) {
    for (var i = 1; i < (presas.length + 6); i++) {
      Map<String, dynamic> map = {
        'value': i,
        'label': i,
        //'icon': Icon(Icons.fiber_manual_record),
      };

      _items.add(map);
      notifyListeners();
    }
  }

  void showOverlay(context) async {
    if (!isOpen) {
      isOpen = true;
      controller.forward();
      OverlayState? overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(builder: (context) => overlayContent);
      overlayState.insert(overlayEntry!);
    }
  }

  void hideOverlay() async {
    if (isOpen) {
      isOpen = false;
      controller.reverse();
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (overlayEntry != null) {
          overlayEntry!.remove();
          overlayEntry = null;
        }
      });
    }
  }

  changePosition(List<String> presas, int numero, int index) {
    late String color;

    switch (c2.value) {
      case 4294198070:
        {
          //case red
          color = "65280";
        }
        break;
      case 4280391411:
        {
          //case blue
          color = "255";
        }
        break;
      case 4283215696:
        {
          color = "16711680";
          //case green
        }
        break;
      case 4294967295:
        {
          //case white
          color = "16777215";
        }
        break;
      case 4288423856:
        {
          color = "65535";
          //case purple
        }
        break;
      case 4294961979:
        {
          //case yellow
          color = "16776960";
        }
        break;
    }

    presas.removeAt(numero - 1);
    presas.insert((int.parse(changeController)) - 1, "$index,$color");

    notifyListeners();
  }

  Future openDialog(BuildContext context, int numero) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return new AlertDialog(
              title: Text("Cambia el orden de esta presa"),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Elige la posición en la que quieres que vaya:"),
                  SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      changeIcon: false,
                      items: _items,
                      initialValue: numero.toString(),
                      onChanged: (val) {
                        val2 = val;
                        //print(_changeController);
                      }),
                  ElevatedButton(
                    onPressed: () {
                      changeController = val2;

                      Navigator.pop(context);
                      notifyListeners();
                    },
                    // buttonstyle:(textColor: Theme.of(context).primaryColor),
                    child: const Text('Cambiar'),
                  ),
                ],
              ),
            );
          }));

  void setC2Transparent() {
    c2 = Colors.transparent;
    notifyListeners();
  }

  void setC2EqualC1() {
    c2 = c1;
    c3 = Color.fromARGB(193, 126, 124, 124);
    notifyListeners();
  }
}
