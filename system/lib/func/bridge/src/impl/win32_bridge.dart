import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../web_bridge_contract.dart';
import '../webview_utils.dart';

/// 针对 Go WebView 客户端
class Win32Bridge implements WebBridgeContract {
  @override
  Future<void> startDragging() async {
    callVoidMethod("window_drag", []);
  }

  @override
  Future<void> minimize() async {
    callVoidMethod("window_minimize", []);
  }

  @override
  Future<void> restore() async {
    callVoidMethod("window_restore", []);
  }

  @override
  Future<void> setSize(double width, double height) async {
    callVoidMethod('window_setSize', [width.ceil(), height.ceil()]);
  }

  @override
  Future<void> maximize() async {
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
    return Size(width, height);
  }

  @override
  Future<void> setWindowSize(double width, double height) async {
    callVoidMethod('window_setSize', [width.ceil(), height.ceil()]);
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
    callVoidMethod("window_setResizable", [isResizable]);
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
  Future<bool> isWin32Webview2() async {
    return isWebView2();
  }

  @override
  Future<bool?> clean() {
    throw UnimplementedError();
  }
}
