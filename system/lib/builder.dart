import 'package:device/device.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';

Widget builder(BuildContext context, Widget? child) {
  //toast
  child = ToastificationWrapper(
    child: child!,
  );
  //字体
  child = MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: const TextScaler.linear(1),
    ),
    child: child,
  );
  //滚动条
  child = ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(
      scrollbars: false,
    ),
    child: child,
  );

  //窗体控制
  if (Device.platform == "windows" ||
      Device.platform == "macOS" ||
      Device.platform == "linux" ||
      Device.platform == "fuchsia") {
    child = _WindowManager(
      child: child,
    );
  }

  return child;
}

class _WindowManager extends StatefulWidget {
  final Widget child;

  const _WindowManager({required this.child});

  @override
  State<_WindowManager> createState() => _WindowManagerState();
}

class _WindowManagerState extends State<_WindowManager> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
