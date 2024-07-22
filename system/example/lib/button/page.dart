import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button"),
      ),
      body: Column(
        children: [
          OutlinedButton(onPressed: (){}, child: Text("OutlinedButton")),
        ],
      ),
    );
  }
}
