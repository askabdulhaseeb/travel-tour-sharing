import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/noPlaceSelectedYet.dart';
import 'widgets/showPlaceImageAndName.dart';
import 'SearchLocation/SearchStartingPoint.dart';
import 'SearchLocation/searchEndingPoint.dart';
import '../../../providers/placesproviders.dart';

class ShowLocatedPoints extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      child: Form(
        key: _key,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _size.width / 2.7,
              height: _size.width / 2.7,
              child: (Provider.of<PlacesProvider>(context).startingPoint ==
                      null)
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SearchStartingPoint.routeName);
                      },
                      child: NoPlaceSelectedYetWidget(
                        title: 'Departure Point',
                      ),
                    )
                  : ShowPlaceImageAndName(
                      place: Provider.of<PlacesProvider>(context).startingPoint,
                    ),
            ),
            // Ending point
            const Icon(Icons.arrow_forward_rounded),
            Container(
              width: _size.width / 2.7,
              height: _size.width / 2.7,
              child: (Provider.of<PlacesProvider>(context).endingPoint == null)
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SearchEndingPoint.routeName);
                      },
                      child: NoPlaceSelectedYetWidget(
                        title: 'Destination Point',
                      ),
                    )
                  : ShowPlaceImageAndName(
                      place: Provider.of<PlacesProvider>(context).endingPoint,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
