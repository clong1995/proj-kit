import 'dart:ui';
import 'package:system/func/window_manager/window_manager_interface.dart';

class WindowManager implements WindowManagerInterface {
  @override
  Future<void> close() {
    throw UnimplementedError();
  }

  @override
  Future<Size> getSize() {
    throw UnimplementedError();
  }

  @override
  Future<void> setSize(Size size, {bool animate = false}) {
    throw UnimplementedError();
  }

  @override
  Future<void> startDragging() {
    throw UnimplementedError();
  }

  @override
  Future<void> minimize({bool vertically = false}) {
    throw UnimplementedError();
  }

  @override
  Future<void> maximize() {
    throw UnimplementedError();
  }

  @override
  Future<void> restore() {
    throw UnimplementedError();
  }

  @override
  Future<Size> screenSize() {
    // TODO: implement screenSize
    throw UnimplementedError();
  }

  @override
  Future<void> setResizeable(bool flag) {
    // TODO: implement setResizeable
    throw UnimplementedError();
  }

  @override
  Future<void> setAlwaysTop(bool flag) {
    // TODO: implement setAlwaysTop
    throw UnimplementedError();
  }

  @override
  Future<void> showWindowTitleBar(bool flag) {
    // TODO: implement showWindowTitleBar
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isMaximized() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> unmaximize() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> init([Size? windowSize]) async {
  }
}
