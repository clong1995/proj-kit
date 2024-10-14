abstract class IStorage {
  Future<void> setValue(String key, String value);

  Future<String> getValue(String key);
}
