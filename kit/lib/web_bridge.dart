import 'dart:ui';

abstract class WebBridge  {
  Future<Size> getDesktopSize();

  Future<Size> getCurrentSize();

  Future<void> setWindowSize(double width, double height);

  Future<void> setMinSize(double width, double height);

  Future<void> setMaxSize(double width, double height);

  Future<String> guid();

  Future<void> open(String url);

  bool isWebView2() => false;
}
