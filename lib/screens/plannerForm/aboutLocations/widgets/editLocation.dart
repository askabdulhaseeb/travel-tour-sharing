import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/placesproviders.dart';
import '../../../plannerForm/aboutLocations/SearchLocation/SearchStartingPoint.dart';
import '../../../plannerForm/aboutLocations/SearchLocation/searchEndingPoint.dart';

class EditLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      color: Colors.blue[900],
      decoration: TextDecoration.underline,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (Provider.of<PlacesProvider>(context).startingPoint == null)
              ? Container()
              : GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SearchStartingPoint.routeName),
                  child: Text(
                    'Edit Departure',
                    style: _textStyle,
                  ),
                ),
          (Provider.of<PlacesProvider>(context).endingPoint == null)
              ? Container()
              : GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SearchEndingPoint.routeName),
                  child: Text(
                    'Edit Destination',
                    style: _textStyle,
                  ),
                ),
        ],
      ),
    );
  }
}
