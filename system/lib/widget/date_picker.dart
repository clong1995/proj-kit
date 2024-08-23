import 'dart:core';

import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

import '../func/datetime_format.dart';

class DatePicker extends StatefulWidget {
  final DateTime initial;
  final DateTime first;
  final DateTime last;
  final void Function(DateTime) onChanged;
  final bool useRootNavigator; //防止弹出后失去焦点，龙虎榜，不设置为false鼠标划过用有bug。
  const DatePicker({
    super.key,
    required this.initial,
    required this.first,
    required this.last,
    this.useRootNavigator = true,
    required this.onChanged,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  // DateTime now = DateTime.now();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.r,
      padding: EdgeInsets.symmetric(
        vertical: 5.r,
        horizontal: 10.r,
      ),
      width: 120.r,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: GestureDetector(
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            barrierDismissible: false,
            useRootNavigator: widget.useRootNavigator,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDate: selectedDate,
            firstDate: widget.first,
            lastDate: widget.last,
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            setState(() {
              selectedDate = pickedDate;
            });
            widget.onChanged(selectedDate);
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Text(DateTimeFormat.toStr(selectedDate, "yyyy-MM-dd")),
            ),
            Icon(
              Icons.calendar_month,
              color: Theme.of(context).primaryColor,
              size: 13.r,
            )
          ],
        ),
      ),
    );
  }
}
