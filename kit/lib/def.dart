import 'package:flutter/material.dart';

class Register {
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

  //弹窗
  final Future<bool?> Function({
    required BuildContext context,
    String? content,
    bool useRootNavigator,
  }) alertConfirm;
  final Future<bool?> Function({
    required BuildContext context,
    String? content,
    bool useRootNavigator,
  }) alertDelete;
  final Future<bool?> Function({
    required BuildContext context,
    required String content,
    bool useRootNavigator,
  }) alertInfo;
  final Future<T?> Function<T>({
    required BuildContext context,
    required Widget child,
    bool useRootNavigator,
  }) alertCustom;

  final Widget Function({
    required String title,
    required Widget child,
    Widget? action,
  }) alertContent;

  final Future<void> Function({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) authInit;
  final Future<bool?> Function(String name) authLoad;
  final Future<void> Function() authClean;
  final bool Function() authState;

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

    //弹窗
    required this.alertConfirm,
    required this.alertDelete,
    required this.alertInfo,
    required this.alertCustom,
    required this.alertContent,

    //凭证
    required this.authLoad,
    required this.authInit,
    required this.authClean,
    required this.authState,
  });
}
