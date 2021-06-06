import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/myColors.dart';
import '../../../../../core/myFonts.dart';
import '../../../../../providers/tripDateTimeProvider.dart';

class ShowSelectedDate extends StatelessWidget {
  final TripDate date;
  final Function onClick;

  const ShowSelectedDate({
    Key key,
    @required this.date,
    @required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 54,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 44,
            decoration: BoxDecoration(
              color: Color(0xFFDBF4D6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: greenShade,
                  // size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  (date.getFormatedDate() == null)
                      ? DateFormat('dd/MM/yyyy').format(DateTime.now())
                      : date.getFormatedDate(),
                  style: TextStyle(
                    fontFamily: englishText,
                    color: greenShade,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (onClick != null)
          Positioned(
            right: -14,
            top: -14,
            child: IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.blue[900],
              ),
              onPressed: () {
                onClick(context);
              },
            ),
          ),
      ],
    );
  }
}

 //           date.getFormatedDate() ?? '',
//