import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class DeleteButton extends StatelessWidget {
  final Widget title;
  final void Function()? onTap;

  const DeleteButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      constraints:BoxConstraints(
        minHeight: 24.r
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 5.r,
          ),
          title,
          SizedBox(
            width: 5.r,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 24.r,
              alignment: Alignment.center,
              color: color,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 14.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}