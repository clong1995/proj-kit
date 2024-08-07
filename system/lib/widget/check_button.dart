import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class CheckButton extends StatefulWidget {
  final Widget title;
  final bool checked;
  final void Function(bool)? onTap;

  const CheckButton({
    super.key,
    required this.title,
    this.checked = false,
    this.onTap,
  });

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  void didUpdateWidget(CheckButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    Container child = Container(
      constraints: BoxConstraints(minHeight: 24.r),
      decoration: BoxDecoration(
        color: checked ? color.withOpacity(.1) : Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: checked ? color : Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 5.r,
          ),
          widget.title,
          SizedBox(
            width: 5.r,
          ),
          InkWell(
            onTap: widget.onTap == null
                ? null
                : () {
                    checked = !checked;
                    widget.onTap!(checked);
                    setState(() {});
                  },
            child: Container(
              width: 24.r,
              alignment: Alignment.center,
              child: checked
                  ? Icon(
                      Icons.check_box,
                      color: color,
                    )
                  : const Icon(
                      Icons.check_box_outlined,
                      color: Colors.grey,
                    ),
            ),
          ),
        ],
      ),
    );
    return widget.onTap == null
        ? Opacity(
            opacity: .5,
            child: child,
          )
        : child;
  }
}
