import 'package:flutter/material.dart';
import '../../../models/plan.dart';
import '../../../providers/placesproviders.dart';
import '../../myPlannerScreen/planTile/plan_tile_header.dart';
import '../../planDetailListView/plan_detail_list_view.dart';
import '../../widgets/landscape_image.dart';

class PlanTile extends StatefulWidget {
  final Plan plan;
  final Map<String, Place> place;
  const PlanTile({@required this.plan, @required this.place});
  @override
  _PlanTileState createState() => _PlanTileState();
}

class _PlanTileState extends State<PlanTile> {
  @override
  Widget build(BuildContext context) {
    var simpleTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlanDetailListView(
              plan: widget.plan,
              place: widget.place,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Stack(
          children: [
            LandscapeImageWidget(
              imageUrl: widget.place[widget.plan.destinationPlaceID]
                  ?.getPlaceImageUrl(),
              height: 200,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              width: double.infinity,
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
                    PlanTileHeader(name: widget.plan?.planName),
                    Text(
                      'From: ${widget.place[widget.plan?.departurePlaceID]?.getPlaceName()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: simpleTextStyle,
                    ),
                    Text(
                      widget.plan?.departureDate,
                      style: simpleTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'To: ${widget.place[widget.plan?.destinationPlaceID]?.getPlaceName()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: simpleTextStyle,
                    ),
                    Text(
                      widget.plan?.returnDate,
                      style: simpleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Like: ${widget.plan?.likes?.toString()}',
                    style: simpleTextStyle,
                  ),
                  Text(
                    'Budget: ${widget.plan?.budget?.toString()}',
                    style: simpleTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
