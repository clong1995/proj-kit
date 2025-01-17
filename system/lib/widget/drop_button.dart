import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class DropButton<T> extends StatefulWidget {
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;
  final double? dropHeight;

  const DropButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.dropHeight
  });

  @override
  State<DropButton<T>> createState() => _DropButtonState<T>();
}

class _DropButtonState<T> extends State<DropButton<T>> {
  T? selectedValue;
  List<T> items = [];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    items = widget.items.entries.map((e) => e.key).toList();
  }

  @override
  void didUpdateWidget(DropButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedValue = widget.value;
    items = widget.items.entries.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.r,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
      
          hint: const Text(
            '请选择',
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      widget.items[item]!,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(left: 8.r, right: 5.r),
            width: 90.r,
            height: 35.r,
          ),
          dropdownStyleData:DropdownStyleData(maxHeight: widget.dropHeight),
          menuItemStyleData: MenuItemStyleData(
            height: 35.r,
          ),
        ),
      ),
    );
  }
}
