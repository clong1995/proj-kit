import 'package:example/drag_bar/page.dart';
import 'package:example/toast/page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rpx/rpx.dart';
import 'package:system/builder.dart';
import 'package:system/func/nav.dart';
import 'package:system/kit.dart';
import 'package:system/theme.dart';
import 'package:system/widget/drag_bar/drag_bar.dart';

import 'auth/page.dart';
import 'button/page.dart';
import 'func/func_page.dart';
import 'input/page.dart';
import 'log/page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  Rpx.init();
  await kitInit([], host: 'https://www.example.com', userAgent: '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      builder: builder,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("输入框"),
            onTap: () => Nav.push(context, () => const InputPage()),
          ),
          ListTile(
            title: const Text("Toast"),
            onTap: () => Nav.push(context, () => const ToastPage()),
          ),
          ListTile(
            title: const Text("按钮"),
            onTap: () => Nav.push(context, () => const ButtonPage()),
          ),
          ListTile(
            title: const Text("功能"),
            onTap: () => Nav.push(context, () => const FuncPage()),
          ),
          ListTile(
            title: const Text("auth"),
            onTap: () => Nav.push(context, () => const AuthPage()),
          ),
            ListTile(
            title: const Text("日志"),
            onTap: () => Nav.push(context, () => const LogPage()),
          ),
           ListTile(
            title: const Text("DragBar"),
            onTap: () => Nav.push(context, () => const DragBarPage()),
          ),
        ],
      ),
    );
  }
}
