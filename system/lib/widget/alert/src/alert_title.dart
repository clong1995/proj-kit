import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

import 'config.dart';

class AlertTitle extends StatelessWidget {
  final String text;

  const AlertTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(245, 245, 245, 1),
      height: 35.r,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      margin: Config.bottomPadding,
      child: Row(
        children: [
          Container(
            height: 15.r,
            width: 3.r,
            margin: EdgeInsets.only(right: 5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5.r),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(
              Icons.close_rounded,
              color: Colors.black,
              size: 14.r,
            ),
          )
        ],
      ),
    );
  }
}
