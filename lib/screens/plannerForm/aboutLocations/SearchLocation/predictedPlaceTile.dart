import 'package:flutter/material.dart';
import '../../../../models/location/placesPreditions.dart';

class PredictedPlaceTile extends StatelessWidget {
  final PlacesPreditions _placesPreditions;
  const PredictedPlaceTile(
      {Key key, @required PlacesPreditions placesPreditions})
      : this._placesPreditions = placesPreditions,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: Colors.white24,
      title: Text(_placesPreditions.main_text ?? ''),
      subtitle: Text(_placesPreditions.secondary_text ?? ''),
    );
  }
}
