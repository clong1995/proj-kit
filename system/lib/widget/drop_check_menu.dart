import 'package:flutter/material.dart';

class DropCheckMenu<T> extends StatefulWidget {
  final Map<T, String> items;
  final List<T> selectedKeys;
  final bool isExpanded;
  final ValueChanged<List<T>>? onChanged;
  final double? width;
  const DropCheckMenu(
      {super.key,
      required this.selectedKeys,
      required this.items,
      this.isExpanded = false,
      this.onChanged, this.width});

  @override
  State<DropCheckMenu<T>> createState() => _DropCheckMenuState<T>();
}

class _DropCheckMenuState<T> extends State<DropCheckMenu<T>> {
  List<T> _selectedKeys = [];
  @override
  void initState() {
    super.initState();
    _selectedKeys = widget.selectedKeys.map((k) => k).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<T>(
        color: Colors.white,
        position: PopupMenuPosition.under,
        onSelected: (T value) {
          if (widget.items[value] == null) return;
          setState(() {
            if (_selectedKeys.contains(value)) {
              _selectedKeys.remove(value);
            } else {
              _selectedKeys.add(value);
            }
          });
          if (widget.onChanged != null) widget.onChanged!(_selectedKeys);
        },
        itemBuilder: (BuildContext context) {
          return widget.items.entries.map((e) {
            return CheckedPopupMenuItem<T>(
              value: e.key,
              onTap: (){},
              checked: _selectedKeys.contains(e.key),
              child: Text(e.value),
            );
          }).toList();
        },
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Row(
            mainAxisSize:
                widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  _selectedKeys.isEmpty
                      ? "未选择"
                      : _selectedKeys.map((k) => widget.items[k]).join(","),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _selectedKeys.isEmpty
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedKeys.clear();
                              });
                              if (widget.onChanged != null) {
                                widget.onChanged!(_selectedKeys);
                              }
                            },
                            icon: const Icon(Icons.clear_sharp)),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
