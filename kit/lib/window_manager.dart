
import 'package:flutter/material.dart';

abstract class IWindowManager {
  Future<Size> getSize();

  Future<Size> screenSize();

  Future<void> setSize(Size size, {bool animate = false});

  Future<void> startDragging();

  Future<void> close();

  Future<void> minimize({bool vertically = false});

  Future<void> maximize();

  // 恢复窗口
  Future<void> restore();

  Future<void> setResizeable(bool isResizable);

  Future<void> setAlwaysTop(bool flag);

  Future<void> showWindowTitleBar(bool flag);
}
