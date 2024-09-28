

import 'log_bridge.dart';
import 'web_bridge.dart';

abstract class WebBridgeContract implements WebBridge,LogBridge {
  Future<void> startDragging();

  Future<void> minimize();

  Future<void> restore();

  Future<void> setSize(double width, double height);

  Future<void> maximize();

  Future<void> close();

  Future<void> setResizeable(bool isResizable);

  Future<void> setAlwaysOnTop(bool flag);

  Future<void> showWindowTitleBar(bool show);

  Future<String> guid();
}
