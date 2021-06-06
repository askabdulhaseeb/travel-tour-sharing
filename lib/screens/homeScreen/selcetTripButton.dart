import 'package:dummy_project/core/myColors.dart';
import 'package:flutter/material.dart';
import '../PlannerForm/plannerFormScreen.dart';
import '../../../core/myFonts.dart';

class SelectTripButton extends StatelessWidget {
  final int currentPage;
  const SelectTripButton({
    @required this.currentPage,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //TODO:on Select Trip Go to Ralitive Planner Page
        Navigator.of(context).pushNamed(PlannerFormScreen.routeName);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [greenShade, greenShade],
          ),
        ),
        child: Text(
          'Select Trip',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: englishText,
          ),
        ),
      ),
    );
  }
}
