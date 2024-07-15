import 'package:flutter/material.dart';
import 'package:system/widget/input.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("输入框"),
      ),
      body: Input(
        onChanged: (String text) {},
      ),
    );
  }
}
