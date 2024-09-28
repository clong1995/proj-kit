import 'storage_interface.dart';

class Storage implements StorageInterface {
  @override
  Future<String?> get(String key) => throw UnsupportedError('unsupported');

  @override
  Future<bool?> remove(String key) => throw UnsupportedError('unsupported');

  @override
  Future<bool?> clean() => throw UnsupportedError('unsupported');

  @override
  Future<bool?> set(String key, String value) =>
      throw UnsupportedError('unsupported');

  @override
  Future<bool?> containsKey(String key) =>
      throw UnsupportedError('unsupported');
}
