import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:guid/guid.dart';

class Encrypt{
  static Encrypter? _encrypter;
  static  IV? _iv;

  static Future<String?> encrypt(String value) async {
    _encrypter ??= await _idEncrypter();
    _iv ??= _bytesVi();

    if (_encrypter == null) return null;

    Encrypted encrypted = _encrypter!.encrypt(value, iv: _iv);
    return encrypted.base64;
  }

  static Future<String?> decrypt(String value)async{
    Encrypted encrypted;
    try {
      encrypted = Encrypted.fromBase64(value);
    } catch (e) {
      return null;
    }

    _encrypter ??= await _idEncrypter();
    if (_encrypter == null) return null;
    _iv ??= _bytesVi();

    String decrypted;
    try {
      decrypted = _encrypter!.decrypt(encrypted, iv: _iv);
    } catch (e) {
      return null;
    }

    return decrypted;
  }

  static IV _bytesVi(){
    return IV(_lenBytes("Code By HuaZhimeng", 16));
  }

  static Future<Encrypter> _idEncrypter() async {
    String id = await Guid.id;
    Uint8List lenBytes = _lenBytes(id, 32);
    Key key = Key(lenBytes);
    return Encrypter(AES(key));
  }

  static Uint8List _lenBytes(String input, int len) {
    List<int> inputBytes = utf8.encode(input);
    if (inputBytes.length < len) {
      inputBytes = List<int>.from(inputBytes)
        ..addAll(List<int>.filled(len - inputBytes.length, 0));
    } else if (inputBytes.length > len) {
      inputBytes = inputBytes.sublist(0, len);
    }
    return Uint8List.fromList(inputBytes);
  }
}