import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/places_type_catalog.dart';
import 'package:dummy_project/models/directions.dart';
import 'package:dummy_project/models/place_type_catalog.dart';
import 'package:dummy_project/screens/plannerMapScreen/map/directions_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/myColors.dart';
import '../../../database/databaseMethod.dart';
import '../../../database/planMethods.dart';
import '../../../database/userLocalData.dart';
import '../../../models/plan.dart';
import '../../../providers/placesproviders.dart';
import '../../../providers/tripDateTimeProvider.dart';
import '../../homeScreen/homeScreen.dart';
import '../../widgets/showLoadingDialog.dart';

class SavePlanButton extends StatelessWidget {
  final GlobalKey<FormState> _globalKey;
  final TextEditingController controller;
  final bool isPublic;
  const SavePlanButton({
    @required globalKey,
    @required this.controller,
    @required this.isPublic,
  }) : this._globalKey = globalKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_globalKey.currentState.validate()) {
          showLoadingDislog(context, 'message');
          TripDateTimeProvider tripDateTimeProvider =
              Provider.of<TripDateTimeProvider>(context, listen: false);
          PlacesProvider placesProvider =
              Provider.of<PlacesProvider>(context, listen: false);
          List<String> _plantype = placesProvider?.endingPoint?.getPlaceTypes();
          final Directions _duration =
              await DirectionsRepository().getDirections(
            origin: LatLng(placesProvider?.startingPoint?.getPlaceLatitude(),
                placesProvider?.startingPoint?.getPlaceLongitude()),
            destination: LatLng(placesProvider?.endingPoint?.getPlaceLatitude(),
                placesProvider?.endingPoint?.getPlaceLongitude()),
          );
          int _distance = _giveDistanceInInt(_duration.totalDistance);
          //( Distance / Average ) * Fule price
          double _budget = (_distance / 10) * 110;
          Plan _plan = Plan(
            planID: '',
            uid: UserLocalData.getUserUID(),
            planName: controller?.text?.trim(),
            departurePlaceID: placesProvider?.startingPoint?.getPlaceID(),
            destinationPlaceID: placesProvider?.endingPoint?.getPlaceID(),
            planType: _plantype,
            isPublic: isPublic,
            likes: 0,
            budget: _budget,
            timeStemp: Timestamp.now(),
            departureTime:
                tripDateTimeProvider?.departureTime?.getFormatedTime(),
            destinationTime:
                tripDateTimeProvider?.returnTime?.getFormatedTime(),
            departureDate:
                tripDateTimeProvider?.startingDate?.getFormatedDate(),
            returnDate: tripDateTimeProvider?.endingDate?.getFormatedDate(),
          );
          await PlanMethods().storePlanAtFirebase(_plan);

          final List<String> _userInterest = UserLocalData.getUserInterest();
          List<String> _allCatelogId = [];
          final QuerySnapshot _catDoc =
              await PlacesTypeCatalogMethods().getAllPlacesCatalog();
          _catDoc.docs.forEach((element) {
            final PlacesTypeCatalog temp =
                PlacesTypeCatalog.fromDocument(element);
            _allCatelogId.add(temp.id);
          });
          _plantype?.forEach((pType) {
            if (_allCatelogId.contains(pType)) {
              if (!_userInterest.contains(pType)) {
                _userInterest.add(pType);
              }
            }
          });
          await DatabaseMethods().updateUserDoc(
            uid: UserLocalData.getUserUID(),
            userMap: {'interest': _userInterest},
          );
          UserLocalData.setUserInterest(_userInterest);
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        } else {
          print('Error in Button');
        }
      },
      child: Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: greenShade,
        ),
        child: Center(
          child: Text(
            'Save My Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  int _giveDistanceInInt(String distance) {
    String temp = "";
    for (int i = 0; i < distance.length; i++) {
      if (distance[i] == '1' ||
          distance[i] == '2' ||
          distance[i] == '3' ||
          distance[i] == '4' ||
          distance[i] == '5' ||
          distance[i] == '6' ||
          distance[i] == '7' ||
          distance[i] == '8' ||
          distance[i] == '9' ||
          distance[i] == '0') {
        temp += distance[i];
      }
    }
    return int.parse(temp);
  }
}
