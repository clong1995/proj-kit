import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'nio.dart';

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
  final Widget Function({
    required Widget Function(double scale) builder,
    required double width,
    required double height,
  }) adaptBox;

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

  //输入框
  final Widget Function({
    double? width,
    double? height,
    bool maxLines,
    BorderSide? borderSide,
    String? text,
    String? hint,
    required void Function(String) onChanged,
  }) input;

  //工具栏
  final Widget Function({
    String title,
    required List<Widget> children,
  }) toolBar;

  //搜索框
  final Widget Function({
    String hintText,
    required void Function(String text) onSearchTap,
  }) searchInput;

  //表格
  final Widget Function(
      {required List<double> cellsWidth,
      required List<List<Widget>> data,
      double headerHeight,
      double cellHeight,
      BorderSide? borderSide}) table;

  //凭证
  final Future<void> Function({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) authInit;
  final Future<bool?> Function(String name) authLoad;
  final Future<void> Function() authClean;
  final bool Function() authState;

  //请求
  final Future<T> Function<S extends BaseReq, T extends BaseRes>(
    String uri, {
    S? req,
    T? res,
    Uint8List? binary,
  }) nio;

  //路由操作
  final Future<T?> Function<T extends Object?>(BuildContext, Widget Function(),
      {bool root, Object? args}) push;
  final void Function<T extends Object?>(BuildContext context,
      {bool root, T? result}) pop;
  final Future<T?> Function<T extends Object?>(
      BuildContext context, Widget Function() page,
      {bool root, Object? args}) pushAndRemove;
  final T? Function<T>(BuildContext context) routeArgs;
  final String Function() sid;

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
    required this.adaptBox,

    //弹窗
    required this.alertConfirm,
    required this.alertDelete,
    required this.alertInfo,
    required this.alertCustom,
    required this.alertContent,

    //输入框
    required this.input,
    //工具栏
    required this.toolBar,
    //搜索框
    required this.searchInput,
    //表格
    required this.table,

    //凭证
    required this.authLoad,
    required this.authInit,
    required this.authClean,
    required this.authState,

    //请求
    required this.nio,

    //路由操作
    required this.push,
    required this.pushAndRemove,
    required this.pop,
    required this.routeArgs,

    //唯一id
    required this.sid,
  });
}
