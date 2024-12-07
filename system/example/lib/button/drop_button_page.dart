import 'package:flutter/material.dart';
import 'package:system/widget/drop_button.dart';

class DropButtonPage extends StatefulWidget {
  const DropButtonPage({super.key});

  @override
  State<DropButtonPage> createState() => _DropButtonPageState();
}

class _DropButtonPageState extends State<DropButtonPage> {
  Map<int, String> items = {1:'item1'};
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropButton(items: items,dropHeight:300),
          FilledButton(
              onPressed: () {
                int k = items.keys.last + 1;
                setState(() {
                  items = {...items, k: 'item$k'};
                });
              },
              child: const Text("增加选项"))
        ],
      ),
    );
  }
}
