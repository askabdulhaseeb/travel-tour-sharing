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
      onTap: () async {},
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
