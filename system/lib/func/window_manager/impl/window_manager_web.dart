import 'dart:ui';

import 'package:kit/window_manager.dart';

import '../../bridge/src/bridge_factory.dart';
import '../../bridge/src/web_bridge_contract.dart';




class WindowManager implements IWindowManager {
  //WebBridgeContract webBridge = Win32TestBridge();
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
  Future<void> minimize({bool vertically = false}) => webBridge.minimize();

  @override
  Future<void> maximize() => webBridge.maximize();

  @override
  Future<void> restore() => webBridge.restore();

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
}
