abstract class StorageInterface {
  Future<String?> get(String key);

  Future<bool?> remove(String key);

  Future<bool?> clean();

  Future<bool?> set(String key, String value);

  Future<bool?> containsKey(String key);
}
