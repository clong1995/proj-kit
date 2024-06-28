import 'package:shared_preferences/shared_preferences.dart';

class _Auth {
  static const String ak = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const String sk = "AAAAAAAAAAA";
  static String accessKeyID = "";
  static String userID = "";
  static String secretAccessKey = "";
  static String key = "";
}

class Auth {
  static String get accessKeyID => _Auth.accessKeyID;

  static String get userID => _Auth.userID;

  static String get secretAccessKey => _Auth.secretAccessKey;

  static late SharedPreferences _prefs;

  //从本地加载凭证
  static Future<bool?> load(String key) async {
    _prefs = await SharedPreferences.getInstance();
    _Auth.key = "__$key";
    String content = _prefs.getString(_Auth.key) ?? "";
    if (content.isEmpty) {
      return false;
    }
    List<String> lines = content.split('\n');
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
  static bool state()=>_state;


  static Future<bool> _set() async {
    if (!_state) {
      //状态不对，设置默认的
      _Auth.accessKeyID = _Auth.ak;
      _Auth.secretAccessKey = _Auth.sk;
      _Auth.userID = "";
    }
    return await _prefs.setString(_Auth.key,
        "${_Auth.accessKeyID}\n${_Auth.secretAccessKey}\n${_Auth.userID}");
  }
}
