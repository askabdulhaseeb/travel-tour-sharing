import 'package:flutter/material.dart';
import '../../../models/plan.dart';
import '../widgets/homeAppBar.dart';
import 'map/showGoogleMap.dart';

class PlanMapViewScreen extends StatelessWidget {
  static final routeName = '/PlanMapViewScreen';
  final Plan plan;
  final Map<String, dynamic> place;

  const PlanMapViewScreen({
    Key key,
    this.plan,
    this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Stack(
        children: [
          ShowGoogleMap(plan: plan, place: place),
        ],
      ),
    );
  }
}
