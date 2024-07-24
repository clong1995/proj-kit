import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MultipleDropButton<T> extends StatefulWidget {
  final Map<T, String> items;
  final List<T> selectedKeys;
  final double? width;
  final ValueChanged<List<T>>? onChanged;

  const MultipleDropButton(
      {super.key,
      required this.items,
      required this.selectedKeys,
      this.onChanged,
      this.width});

  @override
  State<MultipleDropButton<T>> createState() => _MultipleDropButtonState<T>();
}

class _MultipleDropButtonState<T> extends State<MultipleDropButton<T>> {
  List<T> items = [];

  List<T> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedKeys.map((k) => k).toList();
    items = widget.items.entries.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: Colors.black26)),
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
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              //disable default onTap to avoid closing menu when selecting an item
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      isSelected
                          ? selectedItems.remove(item)
                          : selectedItems.add(item);
                      //This rebuilds the StatefulWidget to update the button's text
                      setState(() {});
                      //This rebuilds the dropdownMenu Widget to update the check mark
                      menuSetState(() {});
                      if (widget.onChanged != null) {
                        widget.onChanged!(selectedItems);
                      }
                    },
                    child: Container(
                      height: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          if (isSelected)
                            const Icon(Icons.check_box_outlined)
                          else
                            const Icon(Icons.check_box_outline_blank),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.items[item]!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
          value: selectedItems.isEmpty ? null : selectedItems.last,
          onChanged: (value) {},
          selectedItemBuilder: (context) {
            return items.map(
              (item) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    selectedItems.map((k) => widget.items[k]).join(', '),
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(left: 16, right: 8),
            height: 40,
            width: widget.width,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 30,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
