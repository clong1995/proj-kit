import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kit/kit.dart';
import 'package:system/func/window_manager/window_manager.dart';



class Win10DragBar extends StatefulWidget {
  final Widget? child;

  const Win10DragBar({super.key, this.child});

  @override
  State<Win10DragBar> createState() => _Win10DragBarState();
}

class _Win10DragBarState extends State<Win10DragBar> {
  Offset start = Offset.zero;
  PointerDeviceKind? kind;

  @override
  void initState() {
    print("win10 drag bar");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapCancel: () {
      },
      onPanStart: (d) {
        kind = d.kind;
        print("PointerDeviceKind = ${d.kind}");
        // 区别鼠标
        if (kind == PointerDeviceKind.mouse) {
          windowManager.startDragging();
          start = d.globalPosition;
        } else {
          start = d.globalPosition;
        }
      },
      onPanUpdate: (d) {
        if (kIsWeb) {
          if (kind != PointerDeviceKind.mouse) {
            final diff = d.globalPosition - start;
            print("pan update offset:${d.globalPosition}, diff:${diff}");
            kit.webBridge?.moveBy((diff.dx).ceil(), (diff.dy).ceil());
          } else {
            //kit.windowManager.startDragging();
            // print("update start startDragging");
            print("pan update");
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
