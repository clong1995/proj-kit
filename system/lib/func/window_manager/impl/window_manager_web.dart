import 'dart:ui';

import 'package:system/func/window_manager/window_manager_interface.dart';
import '../../bridge/src/bridge_factory.dart';
import '../../bridge/src/web_bridge_contract.dart';

class WindowManager implements WindowManagerInterface {
  //WebBridgeContract webBridge = Win32TestBridge();
  bool _isMaximized = false;
  WebBridgeContract webBridge = BridgeFactory.webContractBridge();

  @override
  Future<void> close() => webBridge.close();

  @override
  Future<Size> getSize() async {
    return webBridge.initSize();
  }

  @override
  Future<void> setSize(Size size, {bool animate = false}) async {
    await webBridge.setMinSize(size.width, size.height);
    // await webBridge.setSize(size.width, size.height);
    await webBridge.setSize(size.width, size.height);
  }

  @override
  Future<void> startDragging() => webBridge.startDragging();

  @override
  Future<void> minimize({bool vertically = false}) {
    _isMaximized = false;
    return webBridge.minimize();
  }

  @override
  Future<void> maximize() {
    _isMaximized = true;
    return webBridge.maximize();
  }

  @override
  Future<void> restore() {
    _isMaximized = false;
    return webBridge.restore();
  }

  @override
  Future<Size> screenSize() async {
    return await webBridge.getDesktopSize();
  }

  @override
  Future<void> setResizeable(bool isResizable) async {
    return await webBridge.setResizeable(isResizable);
  }

  @override
  Future<void> setAlwaysTop(bool flag) async {
    return await webBridge.setAlwaysOnTop(flag);
  }

  @override
  Future<void> showWindowTitleBar(bool flag) async {
    return await webBridge.showWindowTitleBar(flag);
  }

  @override
  Future<bool> isMaximized() async {
    return _isMaximized;
  }

  @override
  Future<void> unmaximize() {
    _isMaximized = false;
    return webBridge.restore();
  }

  @override
  Future<void> init([Size? windowSize]) async {}
}
