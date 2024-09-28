import 'package:shared_preferences/shared_preferences.dart';

import '/func/encrypt.dart';
import 'storage_interface.dart';

class Storage implements StorageInterface {
  Storage._privateConstructor();

  static final Storage _instance = Storage._privateConstructor();

  factory Storage() => _instance;


  SharedPreferences? _prefs;

  @override
  Future<String?> get(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    String? content = _prefs?.getString(key);
    if (content == null) return null;
    String? value = await Encrypt.decrypt(content);
    return value;
  }

  @override
  Future<bool?> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.remove(key);
  }

  @override
  Future<bool?> clean() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.clear();
  }

  @override
  Future<bool?> set(String key, String value) async {
    String? eValue = await Encrypt.encrypt(value);
    if (eValue == null) {
      return null;
    }
    return await _prefs?.setString(key, eValue);
  }

  @override
  Future<bool?> containsKey(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.containsKey(key);
  }
}
