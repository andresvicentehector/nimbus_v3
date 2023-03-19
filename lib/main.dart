import 'package:flutter/material.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Nimbus/template/T8Colors.dart';
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
        primarySwatch: t8_colorPrimary,
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
