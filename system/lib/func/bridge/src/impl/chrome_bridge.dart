import 'dart:ui';

import 'package:flutter/material.dart';

import '../web_bridge_contract.dart';
import 'dart:html' as html;

// 适配 不带壳的浏览器部分
class ChromeBridge extends WebBridgeContract {
  @override
  Future<Size> getDesktopSize() async {
   final view =  WidgetsBinding
        .instance.platformDispatcher.views.first;
    print("getDesktopSize,${view.devicePixelRatio}");
    return WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize;
  }

  @override
  Future<String> getValue(String key) async {
    print("getValue: $key");
    return html.window.localStorage[key] ?? "";
  }

  @override
  Future<void> open(String url) async {}

  @override
  Future<void> setValue(String key, String value) async {
    print("setValue: $key,$value");
    html.window.localStorage[key] = value;
  }

  @override
  Future<void> setWindowSize(double width, double height) async {}

  @override
  Future<void> close() async {
    print("close");
  }

  @override
  Future<String> guid() async {
    return 'unknown';
  }

  @override
  Future<void> logPrintln(String content) async {}

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
    print("setAlwaysOnTop $flag");
  }

  @override
  Future<void> setResizeable(bool isResizable) async {
    print("setResizeable $isResizable");
  }

  @override
  Future<void> setSize(double width, double height) async {
    print("showWindowTitleBar $width,$height");
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
  Future<String> localActivate() async {
    print("localActivate");
    return '';
  }

  @override
  Future<void> setMinSize(double width, double height) async {
    print("setMinSize");
  }

  @override
  Future<void> setFixedSize(double width, double height) async {
    print("setFixedSize");
  }
  
  @override
  Future<bool?> clean() {
    // TODO: implement clean
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement initSize
  Future<Size>  initSize() async => throw UnimplementedError();
  
}

WebBridgeContract webBridge = ChromeBridge();
