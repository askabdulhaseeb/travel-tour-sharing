import 'package:flutter/material.dart';
import '../../../core/myFonts.dart';

class PlannerFormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Please fill out these details so we can generate a customized plan for you!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: englishText,
          ),
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey),
      ],
    );
  }
}
