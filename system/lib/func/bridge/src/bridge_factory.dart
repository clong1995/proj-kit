


import 'impl/win32_bridge.dart';
import 'log_bridge.dart';
import 'storage_bridge.dart';
import 'web_bridge.dart';
import 'web_bridge_contract.dart';

class BridgeFactory {
  static LogBridge logBridge() {
    return Win32Bridge();
  }
    static StorageBridge storageBridge() {
    return Win32Bridge();
  }

  static WebBridge webBridge() {
    return Win32Bridge();
  }

  static WebBridgeContract webContractBridge() {
    return Win32Bridge();
  }
}
