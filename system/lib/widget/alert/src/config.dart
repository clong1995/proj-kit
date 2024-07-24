import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class Config {
  static final double width = 200.r;
  static final TextStyle titleStyle = TextStyle(
    color: Colors.grey.shade700,
  );

  static const EdgeInsets titlePadding = EdgeInsets.zero;
  static const Color barrierColor = Color(0x80000000);
  static final EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 10.r);
  static final EdgeInsets bottomPadding = EdgeInsets.only(bottom: 10.r);
  static final Decoration decoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.grey.shade300),
    ),
  );
}
