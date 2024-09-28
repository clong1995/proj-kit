import 'package:system/func/bridge/bridge.dart';

import 'storage_interface.dart';

class Storage implements StorageInterface {
  WebBridge webBridge = BridgeFactory.webBridge();

  @override
  Future<String?> get(String key) {
    return webBridge.getValue(key);
  }

  @override
  Future<bool?> clean() {
    return webBridge.clean();
  }

  @override
  Future<bool?> set(String key, String value) async {
    await webBridge.setValue(key, value);
    return true;
  }
}
