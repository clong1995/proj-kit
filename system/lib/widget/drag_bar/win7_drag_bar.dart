import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


class Win7DragBar extends StatefulWidget {
  final Widget? child;

  const Win7DragBar({super.key, required this.child});

  @override
  State<Win7DragBar> createState() => _Win7DragBarState();
}

class _Win7DragBarState extends State<Win7DragBar> {
  @override
  void initState() {
    super.initState();
    print("win7 drag bar");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapCancel: () {
        },
        onPanStart: (details) {
          windowManager.startDragging();
        },
        onPanDown: (d) {},
        onPanUpdate: (d) {
        },
        child: Container(
          color: Colors.transparent,
          child: widget.child,
        ));
  }
}
