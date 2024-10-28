import '/func/storage/storage.dart';

class Auth {
  static const String _key = "__auth";

  static const String _ak = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  static const String _sk = "AAAAAAAAAAA";

  static String _accessKeyID = "";

  static String get accessKeyID => _accessKeyID;

  static String _userID = "";

  static String userID() => _userID;

  static String _secretAccessKey = "";

  static String get secretAccessKey => _secretAccessKey;

  //从本地加载凭证
  static Future<bool> load() async {
    String? content = await Storage().get(_key);
    print(content);
    if (content == null) {
      return false;
    }

    List<String> lines = content.split('\n');
    if (lines.length == 3) {
      _accessKeyID = lines[0];
      _secretAccessKey = lines[1];
      _userID = lines[2];
      return true;
    } else {
      return await _set() ?? false;
    }
  }

  //把凭证加写入本地
  static Future<void> init({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) async {
    _accessKeyID = accessKeyID;
    _secretAccessKey = secretAccessKey;
    _userID = userID;
    await _set();
  }

  //临时凭证
  static void initWeak({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) async {
    _accessKeyID = accessKeyID;
    _secretAccessKey = secretAccessKey;
    _userID = userID;
  }

  //清除凭证
  static Future<void> clean() async {
    _accessKeyID = _ak;
    _secretAccessKey = _sk;
    _userID = "";
    await _set();
  }

  //判断状态
  static bool state() =>
      Auth._userID != "" &&
      Auth._accessKeyID != "" &&
      Auth._secretAccessKey != "";

  static Future<bool?> _set() async {
    if (!state()) {
      //状态不对，设置默认的
      _accessKeyID = _ak;
      _secretAccessKey = _sk;
      _userID = "";
    }
    return await Storage()
        .set(_key, "$_accessKeyID\n$_secretAccessKey\n$_userID");
  }
}
