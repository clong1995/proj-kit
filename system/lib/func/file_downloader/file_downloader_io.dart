import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<String?> saveFile(Uint8List data, String filename) async {
  //final directory = await getDownloadsDirectory();
  //final file = File('${directory?.path}/$filename');
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) return null;
  final file = File('$selectedDirectory/$filename');
  await file.writeAsBytes(data);
  debugPrint('File saved to: ${file.path}');
  return file.path;
}
