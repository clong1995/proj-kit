import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

import 'src/alert_cancel_button.dart';
import 'src/alert_title.dart';
import 'src/config.dart';

Future<bool?> delete({
  required BuildContext context,
  String? content,
  bool useRootNavigator = true,
}) async =>
    showDialog<bool>(
      context: context,
      barrierColor: Config.barrierColor,
      barrierDismissible: false,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        title: const AlertTitle(text: "删除提示:"),
        titleTextStyle: Config.titleStyle,
        titlePadding: Config.titlePadding,
        contentPadding: Config.contentPadding,
        content: Container(
          width: Config.width,
          padding: Config.bottomPadding,
          decoration: Config.decoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: Config.bottomPadding,
                child: Icon(
                  Icons.delete_forever_outlined,
                  size: 36.r,
                  color: Colors.red,
                ),
              ),
              Text(
                content ?? "确定要删除吗?",
              ),
            ],
          ),
        ),
        actions: <Widget>[
          const AlertCancelButton(),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(.2),
              shadowColor: Colors.red.withOpacity(.2),
            ),
            child: const Text(
              "删除",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          )
        ],
      ),
    );
