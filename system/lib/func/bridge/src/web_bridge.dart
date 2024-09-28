import 'dart:ui';

import 'storage_bridge.dart';

abstract class WebBridge implements StorageBridge {
  Future<Size> getDesktopSize();

  Future<void> setWindowSize(double width, double height);

  Future<bool> isWin32Webview2();

  Future<void> open(String url);
}
