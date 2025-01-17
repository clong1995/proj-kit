import 'package:flutter/material.dart';
import 'package:system/func/bridge/bridge.dart';


import 'win10_drag_bar.dart';
import 'win7_drag_bar.dart';

class DragBar extends StatelessWidget {
  final Widget? child;

  const DragBar({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      builder: (context,  AsyncSnapshot<String> snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data.toString().toLowerCase().contains("windows 7")) {
            return Win7DragBar(child: child);
          } else {
            return Win10DragBar(child: child);
          }
        }
        return Container(child: child);
      },
      future: BridgeFactory.webBridge().getSystemVersion(),
    );
  }
}
