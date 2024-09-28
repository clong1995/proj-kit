import 'dart:ui';

import '../web_bridge_contract.dart';
import '../webview_utils.dart';

class Win32TestBridge extends WebBridgeContract {
  @override
  Future<void> startDragging() async {
    callVoidMethod("sendMessage", ['DragMove']);
  }

  @override
  Future<void> minimize() async {
    callVoidMethod("sendMessage", ['Minimize']);
  }

  @override
  Future<void> restore() async {
    callVoidMethod("sendMessage", ['Restore']);
  }

  @override
  Future<void> setSize(double width, double height) {
    // TODO: implement setSize
    throw UnimplementedError();
  }

  @override
  Future<void> maximize() async {
    callVoidMethod("sendMessage", ['Maximize']);
  }

  @override
  Future<void> close() async {
    callVoidMethod("sendMessage", ['Close']);
  }

  @override
  Future<Size> getDesktopSize() async {
    try {
      callReceiveMessage("sendMessage", ['DesktopSize']);
      // var d = await callMethod("sendMessage", ['DesktopSize']);
      return Size.zero;
    } catch (e) {
      return Size.zero;
    }
  }

  @override
  Future<String> getValue(String key) async {
    return await callReceiveMessage("GetValue", [key]);
  }

  @override
  Future<void> setValue(String key, String value) {
    return callVoidMethod("sendMessage", ['SetValue', key, value]);
  }

  @override
  Future<void> setWindowSize(double width, double height) {
    // TODO: implement setWindowSize
    throw UnimplementedError();
  }

  @override
  Future<void> setResizeable(bool isResizable) {
    // TODO: implement setResizeable
    throw UnimplementedError();
  }

  @override
  Future<void> setAlwaysOnTop(bool flag) {
    // TODO: implement setAlwaysOnTop
    throw UnimplementedError();
  }

  @override
  Future<void> showWindowTitleBar(bool show) {
    // TODO: implement showWindowTitleBar
    throw UnimplementedError();
  }

  @override
  Future<String> guid() {
    // TODO: implement guid
    throw UnimplementedError();
  }

  @override
  Future<void> logPrintln(String content) {
    // TODO: implement writeLogs
    throw UnimplementedError();
  }

  @override
  Future<bool> isWin32Webview2() {
    // TODO: implement isWin32Webview2
    throw UnimplementedError();
  }

  @override
  Future<bool?> clean() {
    // TODO: implement clean
    throw UnimplementedError();
  }
}
