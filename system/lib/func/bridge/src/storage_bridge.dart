abstract class StorageBridge {
  Future<void> setValue(String key, String value);
  Future<String> getValue(String key);
  Future<bool?> clean();
}
