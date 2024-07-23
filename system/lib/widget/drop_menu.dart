import 'package:flutter/material.dart';

@immutable
class DropMenu<T> extends StatefulWidget {
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;
  final double? width;
  final double? height;
  DropMenu(
      {super.key,
      this.value,
      required this.items,
      this.width,
      this.height,
      this.onChanged})
      : assert(value == null || !items.containsKey(value),
            'the provided value: $value is not in items');

  @override
  State<DropMenu<T>> createState() => _DropMenuState<T>();
}

class _DropMenuState<T> extends State<DropMenu<T>> {
  T? value;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return Container(
          height: widget.height ?? 30,
          padding: const EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
          width: widget.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Text(value == null ? "未选择" : widget.items[value]!,overflow: TextOverflow.ellipsis,)),
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
      menuChildren: widget.items.entries
          .map(
            (e) => SizedBox(
              width: widget.width,
              child: MenuItemButton(
                onPressed: () {
                  setState(() {
                    value = e.key;
                  });
                },
                child: Text(
                  e.value,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
