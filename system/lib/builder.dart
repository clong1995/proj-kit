import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Widget builder(BuildContext context, Widget? child) {
  //toast
  child = ToastificationConfigProvider(
    config: const ToastificationConfig(
      alignment: Alignment.center,
    ),
    child: child!,
  );
  //字体
  child = MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: const TextScaler.linear(1),
    ),
    child: child,
  );
  //滚动条
  child = ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(
      scrollbars: false,
    ),
    child: child,
  );

  //去掉手势
  child =  MouseRegion(
    cursor: SystemMouseCursors.basic,
    child: child,
  );

  return child;
}
