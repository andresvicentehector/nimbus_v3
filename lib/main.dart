import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/listadoVias/listado_screen.dart';

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
                tertiaryContainer: context.resources.color.colorPrimaryText),
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
      routes: {
        ListadoScreen.id: (context) => ListadoScreen(),
      },
    );
  }
}
