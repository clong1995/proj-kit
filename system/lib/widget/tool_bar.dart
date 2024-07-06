import 'package:flutter/material.dart';
import 'package:kit/rpx.dart';

class ToolBar extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ToolBar({
    super.key,
    required this.children,
    this.title = "工具栏",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.r,
      padding: EdgeInsets.all(5.r),
      margin: EdgeInsets.only(bottom: 2.r),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.tune),
          if (title.isNotEmpty) Text(" $title"),
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(width: 10.r),
            // 可以根据需要调整间隔高度或宽度
          ]
        ],
      ),
    );
  }
}
