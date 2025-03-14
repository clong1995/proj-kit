import 'package:flutter/material.dart';

import '../../func/window_manager/window_manager.dart';

class Win7DragBar extends StatefulWidget {
  final Widget? child;

  const Win7DragBar({super.key, required this.child});

  @override
  State<Win7DragBar> createState() => _Win7DragBarState();
}

class _Win7DragBarState extends State<Win7DragBar> {
  bool _resetGesture = false;

  void _reset() {
    setState(() {
      _resetGesture = true;
    });

    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _resetGesture = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print("win7 drag bar");
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (d){
        print("onPointerUp");
        _reset();
      },
      child: Stack(
        children: [
          _resetGesture
              ? Container(
                  color: Colors.transparent,
                  child: widget.child,
                )
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapCancel: () {},
                  onPanStart: (details) {
                    windowManager.startDragging();
                  },
                  onPanDown: (d) {},
                  onPanUpdate: (d) {},
                  child: Container(
                    color: Colors.transparent,
                    child: widget.child,
                  ))
        ],
      ),
    );
  }
}
