import 'package:dummy_project/screens/planFeedScreen/plans_feed_screen.dart';
import 'package:flutter/material.dart';
import 'slider/tripSlider.dart';
import '../widgets/drawer/homeDrawer.dart';
import '../widgets/homeAppBar.dart';
import '../../../core/myFonts.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                "What's the nature of your trip?",
                style: TextStyle(
                  fontFamily: englishText,
                  letterSpacing: 1,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TripSlider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Plans Feed',
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              PlansFeedScreen.routeName, (route) => false);
        },
        child: Icon(
          Icons.feed_outlined,
        ),
      ),
    );
  }
}
