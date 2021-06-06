import 'package:flutter/material.dart';
import '../../../../../core/myFonts.dart';

class DateSectionLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        children: [
          Text(
            'Journey Duration Peroid',
            style: TextStyle(
              fontFamily: englishText,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
