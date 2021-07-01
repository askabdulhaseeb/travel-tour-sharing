import 'package:dummy_project/database/placesMethods.dart';
import 'package:dummy_project/providers/placesproviders.dart';
import 'package:dummy_project/screens/placeDeatilScreen/placeDetailScreen.dart';
import 'package:dummy_project/screens/planDetailListView/plan_detail_list_view.dart';
import 'package:flutter/material.dart';
import '../../core/myColors.dart';
import '../../database/planMethods.dart';
import '../../database/userLocalData.dart';
import '../../models/plan.dart';
import '../planFeedScreen/feed_tile.dart';
import '../homeScreen/homeScreen.dart';

class PlansFeedScreen extends StatefulWidget {
  static final routeName = '/PlansFeedScreen';
  @override
  _PlansFeedScreenState createState() => _PlansFeedScreenState();
}

class _PlansFeedScreenState extends State<PlansFeedScreen> {
  Stream _feed;
  _initPage() async {
    _feed = await PlanMethods().getAllPublicPlans();
    setState(() {});
  }

  @override
  void initState() {
    _initPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder(
            stream: _feed,
            builder: (context, snapshot) {
              if (snapshot?.data?.docs?.length == 0) {
                return Center(
                  child: Text(
                    'No Plan Available Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                );
              }
              return (snapshot.hasData)
                  ? ListView.builder(
                      itemCount: snapshot?.data?.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Plan _plan =
                            Plan.fromDocument(snapshot?.data?.docs[index]);
                        return (_plan.uid != UserLocalData.getUserUID())
                            ? GestureDetector(
                                onTap: () async {
                                  Place dep = await PlacesMethods()
                                      .getPlacesObjectFromFirebase(
                                    _plan.departurePlaceID,
                                  );
                                  Place des = await PlacesMethods()
                                      .getPlacesObjectFromFirebase(
                                    _plan.destinationPlaceID,
                                  );
                                  Map<String, Place> placeMap = {
                                    _plan.departurePlaceID: dep,
                                    _plan.destinationPlaceID: des,
                                  };
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlanDetailListView(
                                        plan: _plan,
                                        place: placeMap,
                                      ),
                                    ),
                                  );
                                },
                                child: FeedTile(plan: _plan),
                              )
                            : Container();
                      },
                    )
                  : Container();
            },
          ),
          Positioned(
            bottom: 40,
            left: 70,
            right: 70,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: greenShade,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "   Let's Travel Pakistan  ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
