import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:flutter_color_picker_wheel/models/layerlink_config.dart';
import 'package:Nimbus/views/wall/funtions/presas_add_delete.dart';

import '../../../viewModels/wall/add_edit_wallBuilder_VM.dart';

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
  AddEditWallVM viewModel = AddEditWallVM();

  @override
  void dispose() {
    if (viewModel.overlayEntry != null) {
      viewModel.overlayEntry!.remove();
      viewModel.overlayEntry = null;
    }
    viewModel.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    viewModel.itemsfunc(widget.presas);
    viewModel.c2 = widget.c2;
    viewModel.changeController = widget.numero.toString();
    viewModel.controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    viewModel.overlayContent = _wheelcontent25();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _box();
  }

  Widget _wheelcontent25() {
    return WheelOverlayEntryContent(
      animationController: viewModel.controller,
      layerLinkConfig: LayerLinkConfig(
          enabled: true, buttonRadius: 15, layerLink: viewModel.layerLink),
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
      hideOverlay: viewModel.hideOverlay,
      onSelect: (Color newColor) {
        viewModel.hideOverlay();
        viewModel.c1 = newColor;
        viewModel.colorController = viewModel.c1.value;
        viewModel.isActivated = false;

        if (viewModel.c1 != Color.fromARGB(40, 0, 0, 0)) {
          addPresa(widget.presas, widget.index, viewModel.colorController,
              widget.sendMessage);
          //print(widget.presas);
          viewModel.setC2EqualC1();

          viewModel.itemsfunc(widget.presas);
        } else {
          deletePresaList(widget.presas, widget.index);
          viewModel.itemsfunc(widget.presas);

          deletePresaWall(widget.sendMessage, widget.index);

          viewModel.setC2Transparent();
          //print(widget.presas);
        }
      },
    );
  }

  Widget _box() {
    return SizedBox(
      height: 32.3,
      child: CompositedTransformTarget(
        link: viewModel.layerLink,
        child: Stack(children: [
          GestureDetector(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: widget.numero == 10000
                              ? Colors.transparent
                              : viewModel.c3,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: widget.c2))),
                  Center(
                      child: widget.numero == 10000
                          ? SizedBox.shrink()
                          : Text("${widget.numero}",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 5,
                                    color: Color.fromARGB(255, 15, 15, 15),
                                    offset: Offset(1, 2),
                                  ),
                                ],
                                color: widget.c2,
                              )))
                ],
              ),
              onTap: () => {viewModel.showOverlay(context)},
              onLongPress: widget.numero == 10000
                  ? () => {}
                  : () async {
                      await viewModel.openDialog(context, widget.numero);
                      if (viewModel.changeController !=
                          widget.numero.toString()) {
                        Future.delayed(const Duration(milliseconds: 500))
                            .then((_) {
                          viewModel.changePosition(
                              widget.presas, widget.numero, widget.index);
                        });

                        viewModel.showOverlay(context);

                        //print(_changeController);
                      }
                    })
        ]),
      ),
    );
  }
}
