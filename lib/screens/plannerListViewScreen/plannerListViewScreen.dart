import 'package:flutter/material.dart';
import '../widgets/homeAppBar.dart';
import 'mapViewButton.dart';

class PlannerListViewScreen extends StatelessWidget {
  static final routeName = '/PlannerListViewScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // DataContainer(date: '12', month: 'Nov', year: '2020'),
              MapViewButton(),
            ],
          ),
        ),
      ),
    );
  }
}
