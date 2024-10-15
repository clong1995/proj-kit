import 'package:flutter/foundation.dart';
import 'package:kit/web_bridge.dart';


import 'impl/web_bridge_stub.dart'
    if (dart.library.html) 'impl/win32_bridge.dart'
    if (dart.library.io) 'impl/web_bridge_stub.dart' as bridge;

import 'impl/web_bridge_stub.dart'
    if (dart.library.html) 'impl/chrome_bridge.dart' as bridge2;
import 'log_bridge.dart';
import 'web_bridge_contract.dart';

class BridgeFactory {
  static LogBridge logBridge() {
    return bridge.webBridge;
  }

  static WebBridge webBridge() {
    return webContractBridge();
  }

  static WebBridgeContract webContractBridge() {
    if (bridge.webBridge.isWebView2()) {
      return bridge.webBridge;
    }
    if (kIsWeb) {
      return bridge2.webBridge;
    }
    return bridge.webBridge;
  }
}
