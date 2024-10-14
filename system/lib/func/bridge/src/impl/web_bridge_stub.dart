import 'dart:ui';

import '../web_bridge_contract.dart';

class WebBridgeStub extends WebBridgeContract {
  @override
  Future<bool?> clean() async {
    print("clean");
    return true;
  }

  @override
  Future<void> close() async {
    print("close");
  }

  @override
  Future<Size> getDesktopSize() async {
    print("getDesktopSize");
    return Size.zero;
  }

  @override
  Future<String> getValue(String key) async {
    print("getValue: $key");
    return 'stub';
  }

  @override
  Future<String> guid() async {
    print("getValue: $guid");
    return '';
  }

  @override
  Future<bool> isWin32Webview2() async {
    return false;
  }

  @override
  Future<void> logPrintln(String content) async {
    print(content);
  }

  @override
  Future<void> maximize() async {
    print("maximize");
  }

  @override
  Future<void> minimize() async {
    print("minimize");
  }

  @override
  Future<void> restore() async {
    print("restore");
  }

  @override
  Future<void> setAlwaysOnTop(bool flag) async {
    print(" setAlwaysOnTop ${flag}");
  }

  @override
  Future<void> setResizeable(bool isResizable) async {
    print("setResizeable $isResizable");
  }

  @override
  Future<void> setSize(double width, double height) async {
    print("setSize $width $height");
  }

  @override
  Future<void> setValue(String key, String value) async {
    print("setValue $key, $value");
  }

  @override
  Future<void> setWindowSize(double width, double height) async {
    print("setWindowSize $width, $height");
  }

  @override
  Future<void> showWindowTitleBar(bool show) async {
    print("showWindowTitleBar $show");
  }

  @override
  Future<void> startDragging() async {
    print("startDragging");
  }
  
  @override
  Future<void> open(String url)async {
    print("url:$url");
  }
  
  @override
  Future<Size> getCurrentSize() async {
   return Size.zero;
  }
  
  @override
  Future<void> setMaxSize(double width, double height) async{
    print("setMaxSize");
  }
  
  @override
  Future<void> setMinSize(double width, double height) async {
       print("setMinSize");
  }
  
  @override
  Future<void> setFixedSize(double width, double height)async {

           print("setFixedSize");
  }
  
  @override
  Future<Size> initSize() async => Size.zero;
}


WebBridgeStub webBridge = WebBridgeStub();