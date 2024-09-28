import 'log_bridge.dart';
import 'storage_bridge.dart';
import 'web_bridge.dart';
import 'web_bridge_contract.dart';
import 'impl/web_bridge_stub.dart'
    if (dart.library.html) 'impl/win32_bridge.dart' as bridge;

class BridgeFactory {
  static LogBridge logBridge() {
    return bridge.webBridge;
  }

  static StorageBridge storageBridge() {
    return bridge.webBridge;
  }

  static WebBridge webBridge() {
    return bridge.webBridge;
  }

  static WebBridgeContract webContractBridge() {
    return bridge.webBridge;
  }
}
