import 'dart:ui';

import 'package:kit/web_bridge.dart';
import 'package:system/func/bridge/src/storage_bridge.dart';

import 'log_bridge.dart';



abstract class WebBridgeContract implements WebBridge, LogBridge,StorageBridge {
  Future<Size> initSize();
  Future<void> startDragging();

  Future<void> minimize();

  Future<void> restore();

  Future<void> setSize(double width, double height);

  Future<void> maximize();

  Future<void> close();

  Future<void> setResizeable(bool isResizable);

  Future<void> setAlwaysOnTop(bool flag);

  Future<void> showWindowTitleBar(bool show);

  Future<void> setFixedSize(double width, double height);
  @override
  Future<void> setMaxSize(double width, double height) async {}

  @override
  Future<Size> getCurrentSize() async => Size.zero;
  @override
  bool isWebView2() => false;
  @override
  Future<String> guid() async {
    return 'unknown';
  }

  Future<void> setInitSize(double width, double height) async {}
  @override
  Future<void> moveBy(int x, int y)  async{}
  @override
  Future<void> moveTo(int x, int y) async {}
  @override
  Future<void> clearCache() async {}
  @override
  Future<String> getSystemVersion() async {
    return  "Unknown";
  }
  
}
