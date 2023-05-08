import 'dart:async';
import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:Nimbus/views/bluettothSetings/widgets/DiscoveryPage.dart';
import 'package:Nimbus/views/bluettothSetings/widgets/SelectBondedDevicePage.dart';
import 'package:Nimbus/template/configuration/ConstantesPropias.dart';
import 'package:provider/provider.dart';

import '../../viewModels/bluetoothSetings/setings_VM.dart';
import '../../viewModels/juegos/navigator_MaterialPage_functions.dart';
import '../z_widgets_comunes/navigation_bar/navigator.dart';
import '../z_widgets_comunes/utils/texto.dart';

// ignore: camel_case_types
class bluetooth_Screen extends StatefulWidget {
  static final String id = "BluetoothSettings";
  final BluetoothDevice? selectedDevice;

  const bluetooth_Screen({this.selectedDevice});

  @override
  _Bluetooth_screen createState() => _Bluetooth_screen();
}

// ignore: camel_case_types
class _Bluetooth_screen extends State<bluetooth_Screen> {
  SettingsVM viewModel = SettingsVM();
  @override
  void initState() {
    super.initState();
    viewModel.box = Hive.box('Viabox');
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      viewModel.setBluetoothState(state);
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
        viewModel.setAdressState(address);
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      viewModel.setBluetoothNameState(name);
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      viewModel.setBluetoothState(state);

      // Discoverable mode is disabled when Bluetooth gets disabled
      viewModel.discoverableTimeoutTimer = null;
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);

    viewModel.discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pos = 4;
    return Scaffold(
        appBar: _appBarBuilder(),
        body: Stack(
          children: [
            ChangeNotifierProvider<SettingsVM>(
                create: (BuildContext context) => viewModel,
                child: Consumer<SettingsVM>(builder: (context, viewModel, _) {
                  return Container(
                    child: _bluetoothScreenBuilder(),
                  );
                })),
            Navigation(
              selectedDevice: widget.selectedDevice,
              pos: pos,
              colorBadd: Theme.of(context).colorScheme.primary,
            )
          ],
        ));
  }

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: texto(
          context.resources.strings.bluetoothScreenAppbar.toUpperCase(),
          context),
    );
  }

  _bluetoothScreenBuilder() {
    return ListView(
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text(context.resources.strings.bluetoothScreenGeneral),
          trailing: ElevatedButton(
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: context.resources.fonts.tittle,
              ),
            ),
            onPressed: () {
              viewModel.navigateToLoginScreen(context);
            },
          ),
        ),
        SwitchListTile(
          title:
              Text(context.resources.strings.bluetoothScreenActivateBluetooth),
          value: viewModel.bluetoothState.isEnabled,
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
              //iewModel.notifyListeners();
            });
          },
        ),
        ListTile(
          title: Text(context.resources.strings.bluetoothScreenBluetoothStatus),
          subtitle: Text(viewModel.bluetoothState.toString()),
          trailing: ElevatedButton(
            child: Text(
              context.resources.strings.bluetoothScreenBluetoothSettings,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: context.resources.fonts.tittle,
              ),
            ),
            onPressed: () {
              FlutterBluetoothSerial.instance.openSettings();
            },
          ),
        ),
        ListTile(
          title: Text(
              context.resources.strings.bluetoothScreenLocalAdapterAddress),
          subtitle: Text(viewModel.address),
        ),
        ListTile(
          title:
              Text(context.resources.strings.bluetoothScreenLocalAdapterName),
          subtitle: Text(viewModel.name),
          onLongPress: null,
        ),
        SwitchListTile(
          title: Text(context.resources.strings.bluetoothScreenInsertPin),
          subtitle: const Text('Pin 1234'),
          value: viewModel.autoAcceptPairingRequests,
          onChanged: (bool value) {
            viewModel.setAutoAcceptPairingRequest(value);
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
                context.resources.strings.bluetoothScreenSearchPairingDevices,
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
        /*  ListTile(
          title: ElevatedButton(
              child: Text(
                'Cambiar idioma a inglés',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
              onPressed: () async {
                cambiarIdioma('en', context);
              }),
        ),*/
        ListTile(
          title: ElevatedButton(
            child: Text(
              context.resources.strings.bluetoothScreenChatwithPaired,
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
              context.resources.strings.bluetoothScreenChangeWall +
                  (version == "15" ? "25 " : "15 "),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              viewModel.navigateToListadoScreen(context, version);
            },
          ),
        ),
        Divider(),
        ListTile(
          title: ElevatedButton(
            child: Text(
              context.resources.strings.bluetoothScreenMakeBackup,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              viewModel.createBackup(context);
            },
          ),
        ),
        ListTile(
          title: ElevatedButton(
            child: Text(
              context.resources.strings.bluetoothScreenLoadBackup,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            onPressed: () {
              viewModel.restoreBackup(context);
            },
          ),
        ),
        SizedBox(height: 80)
      ],
    );
  }
}
