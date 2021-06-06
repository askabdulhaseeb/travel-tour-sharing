import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          Plan _plan = Plan(
            planID: '',
            uid: UserLocalData.getUserUID(),
            planName: controller?.text?.trim(),
            departurePlaceID: placesProvider?.startingPoint?.getPlaceID(),
            destinationPlaceID: placesProvider?.endingPoint?.getPlaceID(),
            planType: _plantype,
            isPublic: isPublic,
            likes: 0,
            budget: 0,
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
          _plantype?.forEach((pType) {
            if (!_userInterest.contains(pType)) {
              _userInterest.add(pType);
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
}
