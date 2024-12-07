import 'package:flutter/material.dart';

class IntroList extends StatefulWidget {
  const IntroList({super.key});

  @override
  State<IntroList> createState() => _IntroListState();
}

class _IntroListState extends State<IntroList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text("dropbutton"),
          onTap: () {
            Navigator.of(context).pushNamed('dropbutton');
          },
        )
      ],
    );
  }
}
