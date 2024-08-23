import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:guid/guid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Auth {
  static const String ak = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const String sk = "AAAAAAAAAAA";
  static String accessKeyID = "";
  static String userID = "";
  static String secretAccessKey = "";
}

class Auth {
  static String get accessKeyID => _Auth.accessKeyID;

  static String get userID => _Auth.userID;

  static String get secretAccessKey => _Auth.secretAccessKey;

  static late SharedPreferences _prefs;

  static final IV _iv = IV(_lenBytes("Code By HuaZhimeng", 16));

  //从本地加载凭证
  static Future<bool> load() async {
    _prefs = await SharedPreferences.getInstance();
    String content = _prefs.getString("__auth") ?? "";
    if (content.isEmpty) {
      return false;
    }

    Encrypted encrypted = Encrypted.fromBase64(content);
    Encrypter encrypter = await _encrypter();
    String decrypted;
    try{
       decrypted = encrypter.decrypt(encrypted, iv: _iv);
    }catch(e){
      return false;
    }

    List<String> lines = decrypted.split('\n');
    if (lines.length == 3) {
      _Auth.accessKeyID = lines[0];
      _Auth.secretAccessKey = lines[1];
      _Auth.userID = lines[2];
    } else {
      return await _set();
    }
    return true;
  }

  //把凭证加写入本地
  static Future<bool> init({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) async {
    _Auth.accessKeyID = accessKeyID;
    _Auth.secretAccessKey = secretAccessKey;
    _Auth.userID = userID;
    return await _set();
  }

  //临时凭证
  static void initWeak({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) async {
    _Auth.accessKeyID = accessKeyID;
    _Auth.secretAccessKey = secretAccessKey;
    _Auth.userID = userID;
  }

  //清除凭证
  static Future<bool> clean() async {
    _Auth.accessKeyID = _Auth.ak;
    _Auth.secretAccessKey = _Auth.sk;
    _Auth.userID = "";
    return await _set();
  }

  //判断状态
  static bool get _state {
    return _Auth.userID != "" &&
        _Auth.accessKeyID != "" &&
        _Auth.accessKeyID != _Auth.ak &&
        _Auth.secretAccessKey != "" &&
        _Auth.secretAccessKey != _Auth.sk;
  }

  static bool state() => _state;

  static String uid() => _Auth.userID;

  static Future<bool> _set() async {
    if (!_state) {
      //状态不对，设置默认的
      _Auth.accessKeyID = _Auth.ak;
      _Auth.secretAccessKey = _Auth.sk;
      _Auth.userID = "";
    }

    Encrypter encrypter = await _encrypter();
    Encrypted encrypted = encrypter.encrypt(
        "${_Auth.accessKeyID}\n${_Auth.secretAccessKey}\n${_Auth.userID}",
        iv: _iv);
    return await _prefs.setString("__auth", encrypted.base64);
  }

  static Future<Encrypter> _encrypter() async {
    String id = await Guid.id;
    Key key = Key(_lenBytes(id, 32));
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
