import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../database/databaseMethod.dart';
import '../../database/placesMethods.dart';
import '../../models/app_user.dart';
import '../../models/plan.dart';
import '../../providers/placesproviders.dart';
import '../myPlannerScreen/planTile/plan_tile_header.dart';
import '../widgets/circularProfileImage.dart';
import '../widgets/landscape_image.dart';

class FeedTile extends StatefulWidget {
  final Plan plan;
  const FeedTile({@required this.plan});

  @override
  _FeedTileState createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
  AppUser _user;
  Place _place;
  Place _depPlace;
  _initPage() async {
    DocumentSnapshot _userDoc =
        await DatabaseMethods().getUserInfofromFirebase(widget.plan.uid);
    _user = AppUser.fromDocument(_userDoc);
    _place = await PlacesMethods()
        .getPlacesObjectFromFirebase(widget.plan.destinationPlaceID);
    _depPlace = await PlacesMethods()
        .getPlacesObjectFromFirebase(widget.plan.departurePlaceID);
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var simpleTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Row(
            children: [
              CircularProfileImage(imageUrl: _user?.imageURL),
              const SizedBox(width: 10),
              Text(
                _user?.displayName ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              LandscapeImageWidget(
                imageUrl: _place?.getPlaceImageUrl(),
                height: 200,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlanTileHeader(name: widget.plan?.planName ?? ''),
                      Text(
                        'From: ${_depPlace?.getPlaceName() ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: simpleTextStyle,
                      ),
                      Text(
                        widget.plan?.departureDate ?? '',
                        style: simpleTextStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'To: ${_place?.getPlaceName() ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: simpleTextStyle,
                      ),
                      Text(
                        widget.plan?.returnDate ?? '',
                        style: simpleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
