import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kit/kit.dart';
import 'package:system/kit.dart';

import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await kitInit(
    //注册到项目里的模块
    registers,
    // null:根据屏幕自动适配,
    //0:不使用适配
    //数字: 按照指定大小适配
    rpx: defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS
        ? null
        : 480, //在桌面端或者web端，假设屏幕最小是960像素，像素密度位2的屏幕。
    //api的地址
    host: "https://api.abc.com",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: kit.appTheme,
      builder: kit.builder,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      locale: const Locale('zh', 'CH'),
      home: kit.package("learn"),
      navigatorObservers: [],
    );
  }
}
