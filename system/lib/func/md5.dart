import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class Md5 {
  //字符串
  static String str(String str) {
    Uint8List content = const Utf8Encoder().convert(str);
    Digest digest = md5.convert(content);
    String md5Str = digest.toString();
    return md5Str;
  }

  //文件
  static Future<String?> file(String filePath) async {
    File file = File(filePath);
    if (!await file.exists()) {
      return null;
    }
    Uint8List bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      return null;
    }
    return byte(bytes);
  }

  static String byte(Uint8List bytes) {
    Digest digest = md5.convert(bytes);
    return digest.toString();
  }
}
