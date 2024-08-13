import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    TextStyle? style,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
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
  final void Function({
    required String accessKeyID,
    required String secretAccessKey,
    required String userID,
  }) authInitWeak;
  final Future<bool> Function() authLoad;
  final Future<void> Function() authClean;
  final bool Function() authState;
  final String Function() authUid;

  //删除按钮
  final Widget Function({
    required Widget title,
    void Function()? onTap,
  }) deleteButton;

  //选择按钮
  final Widget Function({
    required Widget title,
    bool checked,
    void Function(bool)? onTap,
  }) checkButton;

  // 下拉按钮
  final Widget Function<T>({
    T? value,
    required Map<T, String> items,
    ValueChanged<T?>? onChanged,
  }) dropButton;

  final Widget Function<T>({
    required Map<T, String> items,
    required List<T> selectedKeys,
    double? width,
    ValueChanged<List<T>>? onChanged,
  }) multipleDropButton;

  // 日期选择
  final Widget Function({
    required DateTime initial,
    required DateTime first,
    required DateTime last,
    required void Function(DateTime) onChanged,
    bool useRootNavigator,
  }) datePicker;

  // 日期对象转化为字符串
  final String Function(DateTime dateTime, String pattern) dateToStr;

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
  final Widget Function({
    required String versionStore,
    required void Function() callBack,
  }) checkUpdate;

  //toast
  final void Function(String msg) toast;
  final void Function(String msg) toastLoading;
  final void Function() toastDismiss;

  // 文件选择
  final Future<List<int>?> Function({List<String>? allowedExtensions}) pickFile;

  // 链接下载
  final Future<String?> Function(
      {required String url, required String filename}) downloadFile;
  final Future<Uint8List> Function(String url) networkFileBytes;

  // 字节数据保存到本地
  final Future<String?> Function(Uint8List data, String filename) saveFile;

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
    required this.authInitWeak,
    required this.authClean,
    required this.authState,
    required this.authUid,

    //删除按钮
    required this.deleteButton,
    required this.checkButton,
    required this.dropButton,
    required this.multipleDropButton,

    // 日期按钮
    required this.datePicker,
    // 日期转化为字符串
    required this.dateToStr,

    //请求
    required this.nio,

    //路由操作
    required this.push,
    required this.pushAndRemove,
    required this.pop,
    required this.routeArgs,

    //toast
    required this.toast,
    required this.toastLoading,
    required this.toastDismiss,
    // 文件选择
    required this.pickFile,
    required this.downloadFile,
    required this.networkFileBytes,
    required this.saveFile,

    //唯一id
    required this.sid,
    //检查更新
    required this.checkUpdate,
  });
}
