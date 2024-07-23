import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropButton<T> extends StatefulWidget {
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;

  const DropButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Text(
            '请选择',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      widget.items[item]!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
