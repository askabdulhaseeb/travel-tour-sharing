import 'package:flutter/material.dart';
import '../../../../../core/myColors.dart';
import '../../../../../core/myFonts.dart';
import '../../../../../providers/tripDateTimeProvider.dart';

class ShowselectedTime extends StatelessWidget {
  final TripTime time;
  final Function onClick;

  const ShowselectedTime({
    Key key,
    @required this.time,
    @required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 54,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  Icons.timer,
                  color: greenShade,
                ),
                SizedBox(width: 4),
                Text(
                  time.getFormatedTime() ?? '',
                  style: TextStyle(
                    fontFamily: englishText,
                    color: greenShade,
                  ),
                ),
              ],
            ),
          ),
        ),
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