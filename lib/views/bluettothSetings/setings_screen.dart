import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:Nimbus/views/bluettothSetings/widgets/DiscoveryPage.dart';
import 'package:Nimbus/views/bluettothSetings/widgets/SelectBondedDevicePage.dart';
import 'package:Nimbus/template/configuration/ConstantesPropias.dart';
import 'package:Nimbus/viewModels/bluetoothSetings/backup_functions.dart';

import '../../viewModels/bluetoothSetings/changeVersion_functions.dart';
import '../../viewModels/juegos/navigator_MaterialPage_functions.dart';
import '../z_widgets_comunes/navigation_bar/navigator.dart';
import '../z_widgets_comunes/utils/texto.dart';

// ignore: camel_case_types
class bluetooth_Screen extends StatefulWidget {
  final BluetoothDevice? selectedDevice;

  const bluetooth_Screen({this.selectedDevice});

  @override
  _Bluetooth_screen createState() => _Bluetooth_screen();
}

// ignore: camel_case_types
class _Bluetooth_screen extends State<bluetooth_Screen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  late final Box box;
  String _address = "...";
  String _name = "...";
  var isSelected = 4;
  late var width;

  Timer? _discoverableTimeoutTimer;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();
    box = Hive.box('Viabox');
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);

    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pos = 4;
    return Scaffold(
        appBar: _appBarBuilder(),
        body: Stack(
          children: [
            Container(
              child: _bluetoothScreenBuilder(),
            ),
            SizedBox(
              height: 70,
            ),
            Navigation(selectedDevice: widget.selectedDevice, pos: pos)
          ],
        ));
  }

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: texto('Configuración General', context),
    );
  }

  _bluetoothScreenBuilder() {
    return ListView(
      children: <Widget>[
        Divider(),
        ListTile(title: const Text('General')),
        SwitchListTile(
          title: const Text('Activar Bluetooth'),
          value: _bluetoothState.isEnabled,
          onChanged: (bool value) {
            // Do the request and update with the true value then
            future() async {
              // async lambda seems to not working
              if (value)
                await FlutterBluetoothSerial.instance.requestEnable();
              else
                await FlutterBluetoothSerial.instance.requestDisable();
            }

            future().then((_) {
              setState(() {});
            });
          },
        ),
        ListTile(
          title: const Text('Bluetooth status'),
          subtitle: Text(_bluetoothState.toString()),
          trailing: ElevatedButton(
            child: Text(
              'Settings',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              FlutterBluetoothSerial.instance.openSettings();
            },
          ),
        ),
        ListTile(
          title: const Text('Local adapter address'),
          subtitle: Text(_address),
        ),
        ListTile(
          title: const Text('Local adapter name'),
          subtitle: Text(_name),
          onLongPress: null,
        ),
        SwitchListTile(
          title: const Text('Insertar PIN de manera automática al emparejar'),
          subtitle: const Text('Pin 1234'),
          value: _autoAcceptPairingRequests,
          onChanged: (bool value) {
            setState(() {
              _autoAcceptPairingRequests = value;
            });
            if (value) {
              FlutterBluetoothSerial.instance
                  .setPairingRequestHandler((BluetoothPairingRequest request) {
                //print("Trying to auto-pair with Pin 1234");
                if (request.pairingVariant == PairingVariant.Pin) {
                  return Future.value("1234");
                }
                return Future.value(null);
              });
            } else {
              FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
            }
          },
        ),
        ListTile(
          title: ElevatedButton(
              child: Text(
                'Buscar dispositivos para emparejar',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
              onPressed: () async {
                final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DiscoveryPage();
                    },
                  ),
                );

                if (selectedDevice != null) {
                  //print('Discovery -> selected ' + selectedDevice.address);
                } else {
                  //print('Discovery -> no device selected');
                }
              }),
        ),
        ListTile(
          title: ElevatedButton(
            child: Text(
              ' Chat con un dispositivo emparejado',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () async {
              final BluetoothDevice? selectedDevice =
                  await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SelectBondedDevicePage(checkAvailability: false);
                  },
                ),
              );

              if (selectedDevice != null) {
                //print('Connect -> selected ' + selectedDevice.address);
                startChat(context, selectedDevice);
              } else {
                //print('Connect -> no device selected');
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          title: ElevatedButton(
            child: Text(
              ' Cambiar la configuración a la pared de ' +
                  (version == "15" ? "25 grados" : "15 grados"),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              setState(() {
                changeVersion(version);
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: ElevatedButton(
            child: Text(
              ' Hacer una copia de respaldo',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              setState(() {
                createBackup(context);
              });
            },
          ),
        ),
        ListTile(
          title: ElevatedButton(
            child: Text(
              'Cargar una copia de respaldo',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              setState(() {
                restoreBackup(context);
              });
            },
          ),
        ),
      ],
    );
  }
}
