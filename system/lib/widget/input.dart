import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class Input extends StatefulWidget {
  final double? width;
  final bool maxLines;
  final String? text;
  final String? hint;
  final void Function(String) onChanged;

  const Input({
    super.key,
    this.width,
    this.maxLines = false,
    this.text,
    this.hint,
    required this.onChanged,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String? text;
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller?.text = widget.text ?? "";
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? height = 24.r;
    int maxLines = 1;
    double vertical = 0;
    if (widget.maxLines) {
      maxLines = 4;
      vertical = 10.r;
      height = null;
    }
    return SizedBox(
      width: widget.width ?? 300.r,
      height: height,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14.r),
        maxLines: maxLines,
        onChanged: (String text_) {
          text = text_;
          widget.onChanged(text_);
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.r,
            vertical: vertical,
          ),
          fillColor: Colors.white,
          hoverColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5.r),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: const Color.fromRGBO(153, 153, 153, 1),
            fontSize: 14.r,
          ),
        ),
      ),
    );
  }
}
