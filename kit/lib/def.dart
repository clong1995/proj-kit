import 'package:flutter/material.dart';

class Register{
  final String name;
  final Widget Function({
  Object? arg,
  }) packageBuilder;

  Register(this.name, this.packageBuilder);
}

@immutable
class Kit {
  final ThemeData appTheme;
  final Widget Function(BuildContext context, Widget? child) builder;
  //包
  final Widget Function(
    String package, {
    Object? arg,
  }) package;
  //单位
  final double Function(double size) rpx;
  //图片
  final Widget Function({
  required String imageUrl,
  BoxFit? fit,
  }) cachedImage;

  const Kit({
    //单位
    required this.rpx,
    //主题
    required this.appTheme,
    //builder
    required this.builder,
    //获取包
    required this.package,
    //网络图片
    required this.cachedImage,
  });
}
