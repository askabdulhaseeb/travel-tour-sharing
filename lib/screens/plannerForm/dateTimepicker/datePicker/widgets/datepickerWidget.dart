import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function onClick;
  DatePickerWidget({
    Key key,
    @required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        minimumYear: DateTime.now().year,
        maximumYear: DateTime.now().year + 1,
        minimumDate: DateTime.now(),
        onDateTimeChanged: (DateTime dateTime) {
          onClick(dateTime);
        },
      ),
    );
  }
}
