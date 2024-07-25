import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> saveFile(Uint8List data, String filename) async {
    final directory = await getDownloadsDirectory();
  final file = File('${directory?.path}/$filename');
  await file.writeAsBytes(data);
  debugPrint('File saved to: ${file.path}');
  return file.path;
}
