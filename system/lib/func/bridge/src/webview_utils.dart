import 'dart:async';
import 'dart:core';
import 'dart:js';
import 'dart:js_interop';
import 'dart:js_util';
import 'dart:html';

// 暴露给js 的方法
@JS()
external set dartReceiveMessage(JSFunction f);

Future<dynamic> callReceiveMessage(
    String methodName, List<String> arguments) async {
  Completer completer = Completer();
  // 设置js 回调
  dartReceiveMessage = (String data) {
    completer.complete(data);
  }.toJS;
  if (!hasProperty(context['window'], methodName)) {
    completer.completeError("方法名: $methodName 不存在！");
    return completer.future;
  }
  print("method name: $methodName, arguments=$arguments");
  context.callMethod(methodName, arguments);
  return completer.future.timeout(const Duration(milliseconds: 3000));
}

Future<dynamic> callMethod(String methodName, List<String> arguments) async {
  Completer completer = Completer();
  if (!hasProperty(context['window'], methodName)) {
    completer.completeError("方法名: $methodName 不存在！");
    return completer.future;
  }
  print("method name: $methodName, arguments=$arguments");
  context.callMethod(methodName, [
    ...arguments,
    allowInterop((d) {
      completer.complete(d);
    })
  ]);
  return completer.future.timeout(const Duration(milliseconds: 3000));
}

Future<void> callVoidMethod(String methodName, List<dynamic> arguments) async {
  context.callMethod(methodName, arguments);
}

Future<dynamic> callSyncMethod(
    String methodName, List<dynamic> arguments) async {
  return context.callMethod(methodName, arguments);
}

// 检查是否是否在 webview2
bool checkIsWebView2() {
  return hasProperty(context['window'], 'sync_build_info');
}

// 判断是否是手机浏览器
bool isMobile() {
  final userAgent = window.navigator.userAgent.toLowerCase();

  // 常见的手机浏览器关键字
  if (userAgent.contains('mobile') ||
      userAgent.contains('android') ||
      userAgent.contains('iphone') ||
      userAgent.contains('ipad')) {
    return true;
  }
  return false;
}
