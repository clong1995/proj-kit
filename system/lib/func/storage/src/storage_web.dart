import 'storage_interface.dart';

class Storage implements StorageInterface {
  @override
  Future<String?> get(String key) {
    //TODO
    return Future.value(null);
  }

  @override
  Future<bool?> clean() {
    //TODO
    return Future.value(null);
  }

  @override
  Future<bool?> set(String key, String value) {
    //TODO
    return Future.value(null);
  }
}
