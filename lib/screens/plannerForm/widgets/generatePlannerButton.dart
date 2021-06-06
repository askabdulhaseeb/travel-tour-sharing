import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/myColors.dart';
import '../../../database/placesMethods.dart';
import '../../../providers/placesproviders.dart';
import '../../../providers/tripDateTimeProvider.dart';
import '../../suggestedPlannerScreen/seggestedPlannerScreen.dart';

class GeneratePlannerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(SuggestedPlannerScreen.routeName);
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
            'Show Plan',
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
