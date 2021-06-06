import 'package:flutter/material.dart';
import '../../../core/myColors.dart';
import '../../../core/myFonts.dart';

class DateOrTimeButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const DateOrTimeButtonWidget({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: greenShade,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon),
          const SizedBox(width: 4),
          Text(
            title,
            style: TextStyle(fontFamily: englishText),
          ),
        ],
      ),
    );
  }
}
