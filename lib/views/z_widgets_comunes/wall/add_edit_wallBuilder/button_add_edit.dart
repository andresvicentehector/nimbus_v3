import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:flutter_color_picker_wheel/models/layerlink_config.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:Nimbus/viewModels/functions/presas_add_delete.dart';

class WallButton extends StatefulWidget {
  final int index;
  final Function sendMessage;
  final List<String> presas;
  final Color c2;
  final int numero;
  final double height;

  WallButton(
      {required this.index,
      required this.sendMessage,
      required this.c2,
      required this.presas,
      required this.numero,
      required this.height});

  @override
  State<WallButton> createState() => _WallButtonState();
}

class _WallButtonState extends State<WallButton> with TickerProviderStateMixin {
  bool isActivated = false;
  late bool marcar = false;
  late int _colorController;
  late Color c1;
  late Color c2 = Colors.transparent;
  final LayerLink layerLink = LayerLink();
  late Widget overlayContent;
  late AnimationController controller;
  OverlayEntry? _overlayEntry;
  bool isOpen = false;

  bool changeActive = false;
  late var val2;

  late String _changeController = widget.numero.toString();
  late List<Map<String, dynamic>> _items = [];

  _itemsfunc() {
    for (var i = 1; i < widget.presas.length; i++) {
      Map<String, dynamic> map = {
        'value': i,
        'label': i,
        //'icon': Icon(Icons.fiber_manual_record),
      };

      _items.add(map);
    }
  }

  void _showOverlay() async {
    if (!isOpen) {
      isOpen = true;
      controller.forward();
      OverlayState? overlayState = Overlay.of(context);
      _overlayEntry = OverlayEntry(builder: (context) => overlayContent);
      overlayState.insert(_overlayEntry!);
    }
  }

  void _hideOverlay() async {
    if (isOpen) {
      isOpen = false;
      controller.reverse();
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
          _overlayEntry = null;
        }
      });
    }
  }

  _changePosition() {
    late String color;

    switch (widget.c2.value) {
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

    widget.presas.removeAt(widget.numero - 1);
    widget.presas
        .insert((int.parse(_changeController)) - 1, "${widget.index},$color");

    setState(() {});
  }

  Future openDialog() => showDialog(
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
                      initialValue: widget.numero.toString(),
                      onChanged: (val) {
                        val2 = val;
                        //print(_changeController);
                      }),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _changeController = val2;
                      });

                      Navigator.pop(this.context);
                    },
                    // buttonstyle:(textColor: Theme.of(context).primaryColor),
                    child: const Text('Cambiar'),
                  ),
                ],
              ),
            );
          }));

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _itemsfunc();
    c2 = widget.c2;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    overlayContent = _wheelcontent25();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _box();
  }

  Widget _wheelcontent25() {
    return WheelOverlayEntryContent(
      animationController: controller,
      layerLinkConfig: LayerLinkConfig(
          enabled: true, buttonRadius: 15, layerLink: layerLink),
      animationConfig: sunRayLikeAnimationConfig,
      colors: const [
        [
          Colors.red,
        ],
        [Colors.white, Colors.purple],
        [
          Colors.yellow,
        ],
        [
          Colors.green,
        ],
        [
          Colors.blue,
        ],
        [
          Color.fromARGB(40, 0, 0, 0),
        ],
      ],
      innerRadius: 25,
      pieceHeight: 20,
      pieceBorderSize: 0,
      hideOverlay: _hideOverlay,
      onSelect: (Color newColor) {
        _hideOverlay();
        setState(() {
          c1 = newColor;
          _colorController = c1.value;

          isActivated = false;
        });
        if (c1 != Color.fromARGB(40, 0, 0, 0)) {
          addPresa(widget.presas, widget.index, _colorController,
              widget.sendMessage);
          //print(widget.presas);
          setState(() {
            c2 = c1;
          });
        } else {
          deletePresaList(widget.presas, widget.index);

          deletePresaWall(widget.sendMessage, widget.index);

          //print(widget.presas);
          setState(() {
            c2 = Colors.transparent;
          });
        }
      },
    );
  }

  Widget _box() {
    return SizedBox(
      height: 32.3,
      child: CompositedTransformTarget(
        link: layerLink,
        child: Stack(children: [
          GestureDetector(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: c2))),
                  Center(
                      child: widget.numero == 10000
                          ? SizedBox.shrink()
                          : Text("${widget.numero}",
                              style: TextStyle(
                                color: c2,
                              )))
                ],
              ),
              onTap: _showOverlay,
              onLongPress: widget.numero == 10000
                  ? () => {}
                  : () async {
                      await openDialog();
                      if (_changeController != widget.numero.toString()) {
                        Future.delayed(const Duration(milliseconds: 500))
                            .then((_) {
                          _changePosition();
                        });

                        _showOverlay();

                        //print(_changeController);
                      }
                    })
        ]),
      ),
    );
  }
}
