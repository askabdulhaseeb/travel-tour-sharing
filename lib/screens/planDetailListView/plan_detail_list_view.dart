import 'package:flutter/material.dart';
import '../../models/plan.dart';
import '../../providers/placesproviders.dart';
import '../planDetailListView/place_time_detail_card.dart';
import '../plannerMapScreen/plan_map_view_screen.dart';
import '../widgets/homeAppBar.dart';

class PlanDetailListView extends StatefulWidget {
  static const routeName = '/PlanDetailListView';
  final Map<String, Place> place;
  final Plan plan;
  const PlanDetailListView({@required this.plan, @required this.place});
  @override
  _PlanDetailListViewState createState() => _PlanDetailListViewState();
}

class _PlanDetailListViewState extends State<PlanDetailListView> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.plan?.planName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 6),
                DisplayTextOfCost(
                  title: 'Food Per Person/Daily:',
                  price: 700,
                ),
                DisplayTextOfCost(
                  title: 'Accommodation Per Person/Daily:',
                  price: 1000,
                ),
                DisplayTextOfCost(
                  title: 'Fule + ToolTex:',
                  price: widget.plan.budget,
                ),
                const SizedBox(height: 10),
                PlaceTimeDetailsCard(
                  place: widget.place[widget?.plan?.departurePlaceID],
                  date:
                      widget?.plan?.departureDate ?? DateTime.now().toString(),
                  time: widget?.plan?.departureTime ?? '12:00',
                ),
                const SizedBox(height: 10),
                PlaceTimeDetailsCard(
                  place: widget.place[widget?.plan?.destinationPlaceID],
                  date: widget?.plan?.returnDate ?? DateTime.now().toString(),
                  time: widget?.plan?.destinationTime ?? '12:00',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  PlanMapViewScreen(plan: widget.plan, place: widget.place),
            ),
          );
        },
      ),
    );
  }
}

class DisplayTextOfCost extends StatelessWidget {
  final String title;
  final double price;
  const DisplayTextOfCost({
    Key key,
    @required this.title,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? 'Unknown',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$price' ?? '0.0',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
