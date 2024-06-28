import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kit/def.dart';
import 'package:kit/kit.dart';
import 'package:package/package.dart';
import 'package:package/register.dart' as reg;
import 'package:rpx/rpx.dart';
import 'package:system/theme.dart';

import 'builder.dart';
import 'widget/cached_image.dart';

Future<void> kitInit(
  Iterable<Register Function()> registers, {
  //请求地址的host，如 https://api.abc.com
  String? host,
  //null:根据屏幕自动适配,
  //0:不使用适配
  //数字: 按照指定大小适配
  double? rpx,
}) async {
  //系统设置
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));

  //竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //单位
  Rpx.init(rpx);

  //注册包
  Package.register(registers.map((Register Function() element) => () {
        Register r = element();
        return reg.Register(r.name, r.packageBuilder);
      }));

  //初始化kit
  kit = Kit(
    rpx: Rpx.rpx,
    appTheme: appTheme(),
    builder: builder,
    package: Package.package,
    cachedImage: CachedImage.image,
  );
}
