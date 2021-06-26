import 'package:flutter/material.dart';
import '../../../core/myColors.dart';
import '../../../core/myFonts.dart';
import '../plannerMapScreen/plan_map_view_screen.dart';

class MapViewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: GestureDetector(
        onTap: () {
          //TODO:on Select Trip Go to Ralitive Planner Page
          Navigator.of(context).pushNamed(PlanMapViewScreen.routeName);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: greenShade,
          ),
          child: Text(
            'Map View',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: englishText,
            ),
          ),
        ),
      ),
    );
  }
}
