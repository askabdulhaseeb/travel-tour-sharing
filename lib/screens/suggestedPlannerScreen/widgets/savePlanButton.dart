import 'package:dummy_project/screens/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import '../../../core/myColors.dart';

class SavePlanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      },
      child: Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: greenShade,
        ),
        child: Center(
          child: Text(
            'Save My Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
