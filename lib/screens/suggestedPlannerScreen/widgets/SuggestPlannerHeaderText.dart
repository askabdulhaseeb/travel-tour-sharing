import 'package:flutter/material.dart';
import '../../../core/myFonts.dart';

class SuggestPlannerHeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: englishText,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Here is a Suggested Plan for your Trip,',
          style: textStyle,
        ),
        Text('You can also Change it as per your own choice'),
        const SizedBox(height: 20),
        Divider(color: Colors.grey),
      ],
    );
  }
}
