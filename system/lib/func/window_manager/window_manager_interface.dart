import 'package:flutter/material.dart';
import 'package:kit/window_manager.dart';

abstract class WindowManagerInterface implements IWindowManager {
  Future<void> init([Size? windowSize]);
}