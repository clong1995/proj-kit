import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  SharedPreferences? _prefs;

  Future<String?> get(String key) async {
    _forbidden(key);
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString(key);
  }

  Future<bool?> set(String key, String value) async {
    _forbidden(key);
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.setString(key, value);
  }

  Future<bool?> remove(String key) async {
    _forbidden(key);
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.remove(key);
  }

  Future<bool?> containsKey(String key) async {
    _forbidden(key);
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.containsKey(key);
  }

  void _forbidden(key){
    if(key.startsWith("_")){
      throw "do not start with _";
    }
  }
}
