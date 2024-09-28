abstract class StorageInterface {
  Future<String?> get(String key);

  Future<bool?> clean();

  Future<bool?> set(String key, String value);
}
