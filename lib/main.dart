import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/views/addVia/addPresas_screen/add_presas_screen.dart';
import 'package:Nimbus/views/addVia/addVia_screen/add_via_screen.dart';
import 'package:Nimbus/views/bluettothSetings/setings_screen.dart';
import 'package:Nimbus/views/editVia/editPresas_screen/edit_presas_screen.dart';
import 'package:Nimbus/views/editVia/update_screen/update_screen.dart';
import 'package:Nimbus/views/escalarVia/escalar_screen.dart';
import 'package:Nimbus/views/juegos/jugar_screen.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/ListadoVias/AWS/ViaAWS.dart';
import 'views/listadoVias/listado_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  // Initialize hive
  await Hive.initFlutter();

  // Registering the adapter
  Hive.registerAdapter(ViaAdapter());
  // Opening the box
  await Hive.openBox('Viabox');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIMBUS',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
                brightness: Brightness.light,
                primary: context.resources.color.colorPrimary,
                secondary: context.resources.color.colorAccent)
            .copyWith(
                tertiary: context.resources.color.colorPrimaryText,
                tertiaryContainer: context.resources.color.colorSecondaryText),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
                brightness: Brightness.dark,
                primary: context.resources.colorDark.colorPrimary,
                background: Color.fromARGB(31, 6, 1, 51),
                onBackground: Colors.white,
                secondary: context.resources.colorDark.colorAccent)
            .copyWith(
                tertiary: context.resources.colorDark.colorPrimaryText,
                tertiaryContainer: context.resources.colorDark.colorContainer),
      ),
      debugShowCheckedModeBanner: false,
      home: ListadoScreen(),
      initialRoute: ListadoScreen.id,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // Add the newly created delegate

      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Spanish
      ],
      routes: {
        ListadoScreen.id: (context) => ListadoScreen(),
        AddPresas.id: (context) => AddPresas(
              server: ModalRoute.of(context)!.settings.arguments
                  as BluetoothDevice?,
            ),
        AddScreen.id: (context) => AddScreen(
            presas: ModalRoute.of(context)!.settings.arguments as List<String>),
        bluetooth_Screen.id: (context) => bluetooth_Screen(
            selectedDevice:
                ModalRoute.of(context)!.settings.arguments as BluetoothDevice?),
        EditPresas.id: (context) => EditPresas(
            connection: ModalRoute.of(context)!.settings.arguments
                as BluetoothConnection?,
            via: ModalRoute.of(context)!.settings.arguments as Vias),
        UpdateScreen.id: (context) => UpdateScreen(
            via: ModalRoute.of(context)!.settings.arguments as Vias,
            presas: ModalRoute.of(context)!.settings.arguments as List<String>),
        EscalarScreen.id: (context) => EscalarScreen(
              via: ModalRoute.of(context)!.settings.arguments as Vias,
              server: ModalRoute.of(context)!.settings.arguments
                  as BluetoothDevice?,
            ),
        JugarScreen.id: (context) => JugarScreen(
            selectedDevice:
                ModalRoute.of(context)!.settings.arguments as BluetoothDevice?)
      },
    );
  }
}
