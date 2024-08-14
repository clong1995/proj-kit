import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';
import 'package:window_manager/window_manager.dart';

class DesktopBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const DesktopBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      //onPanStart: (details) => windowManager.startDragging(),
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.r);
}
