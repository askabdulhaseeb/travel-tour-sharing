import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  final Function onClick;
  TimePickerWidget({
    Key key,
    @required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
        use24hFormat: true,
        onDateTimeChanged: (DateTime dateTime) {
          onClick(dateTime);
        },
      ),
    );
  }
}
