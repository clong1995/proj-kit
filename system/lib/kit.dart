import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kit/def.dart';
import 'package:kit/kit.dart';
import 'package:package/package.dart';
import 'package:package/register.dart' as reg;
import 'package:rpx/rpx.dart';
import 'package:system/func/nio/src/send.dart';
import 'package:system/theme.dart';
import 'package:system/widget/alert/confirm.dart';
import 'package:system/widget/alert/custom.dart';
import 'package:system/widget/alert/delete.dart';
import 'package:system/widget/alert/info.dart';

import 'builder.dart';
import 'func/auth.dart';
import 'widget/cached_image.dart';

Future<void> kitInit(
  Iterable<Register Function()> registers, {
  //请求地址的host，如 https://api.abc.com
  required String host,
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

  //注册包
  Package.register(registers.map((Register Function() element) => () {
        Register r = element();
        return reg.Register(r.name, r.packageBuilder);
      }));

  //设置全局的请求host
  sendHost(host);

  //竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //单位
  Rpx.init(rpx);

  //初始化kit
  kit = Kit(
    rpx: Rpx.rpx,
    appTheme: appTheme(),
    builder: builder,
    //包管理
    package: Package.package,
    //网络图片
    cachedImage: CachedImage.image,
    //弹窗
    alertConfirm: confirm,
    alertDelete: delete,
    alertInfo: info,
    alertCustom: custom,
    alertContent: CustomContent.new,
    //凭证
    authInit: Auth.init,
    authLoad: Auth.load,
    authClean: Auth.clean,
    authState: Auth.state,
  );
}
