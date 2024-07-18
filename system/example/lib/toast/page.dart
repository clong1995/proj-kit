import 'package:flutter/material.dart';
import 'package:system/widget/toast.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toast"),
      ),
      body: Column(
        children: [
          FilledButton(
            child: const Text("show"),
            onPressed: () {
              Toast.show("show");
              Toast.show("show1");
            },
          ),
          FilledButton(
            child: const Text("loading"),
            onPressed: () {
              Toast.loading("loading");
            },
          ),
        ],
      ),
    );
  }
}
