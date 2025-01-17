import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../web_bridge_contract.dart';
import '../webview_utils.dart';

/// 针对 Go WebView 客户端
class Win32Bridge extends WebBridgeContract {
  // 目标大小
  Size _targetSize = Size.zero;

  // 当前窗口大小
  Size _currentSize = Size.zero;

  // 桌面
  Size _desktopSize = Size.zero;

  // 是否改变大小
  bool _isResized = false;

  Size _initSize = Size.zero;

  @override
  Future<void> setInitSize(double width, double height) async {
    await setSize(width, height);
    _initSize = Size(width, height);
  }

  @override
  Future<void> startDragging() async {
    callVoidMethod("window_drag", []);
  }
  @override
  Future<Size> getCurrentSize() async {
    return _currentSize;
  }

  @override
  Future<void> minimize() async {
    callVoidMethod("window_minimize", []);
  }

  @override
  Future<void> restore() async {
    callVoidMethod("window_unMaximize", []);
    setWindowSize(_targetSize.width, _targetSize.height);
    if (!_isResized) {
      setMaxSize(_targetSize.width, _targetSize.height);
    }
  }

  @override
  Future<void> setSize(double width, double height) async {
    callVoidMethod('window_setSize', [width.ceil(), height.ceil()]);
    _targetSize = Size(width, height);
  }

  @override
  Future<void> maximize() async {
    setMaxSize(_desktopSize.width, _desktopSize.height);
    callVoidMethod("window_maximize", []);
  }

  @override
  Future<void> close() async {
    callVoidMethod("window_terminate", []);
  }

  @override
  Future<Size> getDesktopSize() async {
    final response = await callMethod("sync_desktop_size", []);
    final map = jsonDecode(response);
    double width = double.tryParse(map['width'].toString()) ?? 0;
    double height = double.tryParse(map['height'].toString()) ?? 0;
    // 桌面大小
    _desktopSize = Size(width + 12, height + 12);
    return Size(width, height);
  }

  @override
  Future<void> setWindowSize(double width, double height) async {
    callVoidMethod('window_setSize', [width.ceil(), height.ceil()]);
    _targetSize = Size(width, height);
  }

  @override
  Future<String> getValue(String key) async {
    return await callMethod("sync_storage_get", [key]);
  }

  @override
  Future<void> setValue(String key, String value) async {
    callVoidMethod("storage_set", [key, value]);
  }

  @override
  Future<void> setResizeable(bool isResizable) async {
    _isResized = isResizable;
    if (isResizable) {
      setMaxSize(_desktopSize.width, _desktopSize.height);
    } else {
      setMaxSize(_targetSize.width, _targetSize.height);
    }
    //await callVoidMethod("window_setResizable", [isResizable]);
    if (kDebugMode) {
      print("window_setResizable: $isResizable");
    }
  }

  @override
  Future<void> setAlwaysOnTop(bool flag) async {
    callVoidMethod("window_setAlwaysOnTop", [flag]);
  }

  @override
  Future<void> showWindowTitleBar(bool show) async {
    callVoidMethod("window_setTitleBar", [show]);
  }

  double devicePixelRatio() {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.devicePixelRatio;
  }

  @override
  Future<String> guid() async {
    return await callMethod("sync_systemos_guid", []);
  }

  @override
  Future<void> logPrintln(String content) async {
    await callVoidMethod('log_println', [content]);
  }

  @override
  Future<void> open(String url) async {
    await callVoidMethod('singleton_open', [url]);
  }

  @override
  Future<void> setMinSize(double width, double height) async {
    callVoidMethod('window_setMinSize', [width.ceil() + 13, height.ceil()]);
  }

  @override
  Future<void> setFixedSize(double width, double height) async {
    await callVoidMethod('window_setFixedSize', [width.ceil(), height.ceil()]);
  }

  @override
  bool isWebView2() {
    return checkIsWebView2();
  }

  @override
  Future<void> setMaxSize(double width, double height) async {
    callVoidMethod('window_setMaxSize', [width.ceil(), height.ceil()]);
  }

  @override
  Future<bool?> clean() {
    throw UnimplementedError();
  }

  @override
  Future<Size>  initSize() async=> _initSize;

  @override
  Future<void> moveBy(int x, int y) async {
    await callVoidMethod('window_offset', [x, y]);
  }

  @override
  Future<void> moveTo(int x, int y) async {
    await callVoidMethod('window_position', [x, y]);
  }
  @override
  Future<String> getSystemVersion() async{
    final res = await callMethod("sync_systemos_version", []);
    print("sync_systemos_version:${res}");
    return res.toString();
  }

  @override
  Future<void> clearCache() async {
    await callVoidMethod('cache_clean', [0]);
  }
}

WebBridgeContract webBridge = Win32Bridge();
