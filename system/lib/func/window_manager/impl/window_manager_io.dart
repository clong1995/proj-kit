import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:system/func/window_manager/window_manager_interface.dart';
import 'package:window_manager/window_manager.dart';

class WindowManager implements WindowManagerInterface {
  @override
  Future<void> close() async {
    await windowManager.close();
  }

  @override
  Future<Size> getSize() {
    return windowManager.getSize();
  }

  @override
  Future<void> setSize(Size size, {bool animate = false}) =>
      windowManager.setSize(size, animate: animate);

  @override
  Future<void> startDragging() => windowManager.startDragging();

  @override
  Future<void> minimize({bool vertically = false}) async {
    await windowManager.minimize();
  }

  @override
  Future<void> maximize() async {
    await windowManager.maximize();
  }

  @override
  Future<void> restore() async {
    await windowManager.restore();
  }

  @override
  Future<Size> screenSize() async {
    final d = await ScreenRetriever.instance.getPrimaryDisplay();
    return d.size;
  }

  @override
  Future<void> setResizeable(bool isResizable) async {
    await windowManager.setResizable(isResizable);
  }

  @override
  Future<void> setAlwaysTop(bool flag) async {
    await windowManager.setAlwaysOnTop(flag);
  }

  @override
  Future<void> showWindowTitleBar(bool flag) async {
    await windowManager.setTitleBarStyle(
        flag ? TitleBarStyle.normal : TitleBarStyle.hidden);
  }
  
  @override
  Future<bool> isMaximized() {
    return windowManager.isMaximized();
  }
  
  @override
  Future<void> unmaximize() {
    return windowManager.unmaximize();
  }
  
  @override
  Future<void> init([Size? windowSize])async {
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow(
        WindowOptions(
          size: windowSize,
          center: true,
          minimumSize: windowSize,
          backgroundColor: Colors.transparent,
          titleBarStyle: TitleBarStyle.hidden,
          windowButtonVisibility: false,
        ), () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setResizable(true);
    });
  }
  
  
}
