import 'package:flutter/material.dart';
import 'package:system/widget/drag_bar/drag_bar.dart';
import 'package:system/widget/toast.dart';

class DragBarPage extends StatefulWidget {
  const DragBarPage({super.key});

  @override
  State<DragBarPage> createState() => _DragBarPageState();
}

class _DragBarPageState extends State<DragBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DragBar(
            child: GestureDetector(
              onTap: () {
                Toast.show("点击了鼠标!");
              },
              child: Container(
                margin: const EdgeInsets.all(30),
                height: 60,
                color: Colors.amber,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Text("拖动测试"),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Toast.show("关闭按钮");
                        },
                        icon: Icon(Icons.close)),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                width: double.infinity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
