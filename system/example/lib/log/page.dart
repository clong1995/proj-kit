import 'dart:io';

import 'package:flutter/material.dart';
import 'package:system/func/log/log.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              String lastFolder = Uri.file(Directory.current.path).pathSegments.last;
              log('这是一条日志$lastFolder');
            }, child: const Text("打印日志"))
          ],
        ),
      ),
    );
  }
}