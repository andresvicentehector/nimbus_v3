import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/ListadoVias/hive/via.dart';

late Box box = Hive.box('Viabox');

Future<void> createBackup(context) async {
  if (box.isEmpty) {
    //print("no products Stored");
    return;
  }
  /*ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Creating backup...')),
  );*/
  //print("Creating Backup");

  var raw = box.toMap();
  List list = raw.values.toList();

  String json = jsonEncode(list);
  await Permission.storage.request();
  Directory dir = await _getDirectory();
  String formattedDate = DateTime.now()
      .toString()
      .replaceAll('.', '-')
      .replaceAll(' ', '-')
      .replaceAll(':', '-');
  String path =
      '${dir.path}$formattedDate.json'; //Change .json to your desired file format(like .barbackup or .hive).
  File backupFile = File(path);

  await backupFile.writeAsString(json);
  /*ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Backup saved in folder vuit')),
  );*/
}

Future<Directory> _getDirectory() async {
  const String pathExt =
      'vuit/'; //This is the name of the folder where the backup is stored
  Directory newDirectory = Directory('/storage/emulated/0/Download/' +
      pathExt); //Change this to any desired location where the folder will be created
  if (await newDirectory.exists() == false) {
    return newDirectory.create(recursive: true);
  }
  return newDirectory;
}

Future<void> restoreBackup(context) async {
  /* ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Restoring backup...')),
  );*/
  //print("Restoring Back_Up");
  FilePickerResult? file = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (file != null) {
    File files = File(file.files.single.path.toString());
    await box.clear();

    //await files.readAsString();
    List<dynamic> map = jsonDecode(await files.readAsString());

    for (var i = 0; i < map.length; i++) {
      final item = map[i];
      //print(item['presas'].cast<String>());
      box.put(
          i,
          new Via(
              name: item['name'],
              autor: item['autor'],
              dificultad: item['dificultad'],
              comentario: item['comentario'],
              presas: item['presas'].cast<String>(),
              isbloque: item['isbloque'],
              quepared: item['quepared']));
    }
    /* ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Restored Successfully...')),
    );*/
    //print("Restored with Successs boy");
    await Navigator.of(context).pushNamed("/");
  }
}
