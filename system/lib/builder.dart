import 'package:flutter/material.dart';

Widget builder(BuildContext context, Widget? child) {
  //字体
  child = MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: const TextScaler.linear(1),
    ),
    child: child!,
  );
  //滚动条
  child = ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(
      scrollbars: false,
    ),
    child: child,
  );
  return child;
}
