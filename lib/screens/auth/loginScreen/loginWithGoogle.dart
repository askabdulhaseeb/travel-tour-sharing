import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../auth/authorisation.dart';
import '../../../core/myColors.dart';
import '../../../core/myPhotos.dart';
import '../../../database/databaseMethod.dart';
import '../../../models/app_user.dart';
import '../../allPlacesTypeScreen/all_places_type_screeen.dart';
import '../../planFeedScreen/plans_feed_screen.dart';
import '../../widgets/showLoadingDialog.dart';

class LoginWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: greenShade,
      onTap: () async {
        showLoadingDislog(context, 'Wait');
        User _user = await AuthMethods().signInWithGoogle(context);
        Navigator.of(context).pop();
        if (_user != null) {
          final DocumentSnapshot temp =
              await DatabaseMethods().getUserInfofromFirebase(
            _user.uid,
          );
          if (temp.exists) {
            AppUser _ctUser = AppUser.fromDocument(temp);
            if (_ctUser.interest.length > 4) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                PlansFeedScreen.routeName,
                (route) => false,
              );
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AllPlacesTypeScreen.routeName,
                (route) => false,
              );
            }
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AllPlacesTypeScreen.routeName,
              (route) => false,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Incorrect Email or Password',
            backgroundColor: Colors.red,
          );
        }
      },
      child: Container(
        height: 44,
        width: 190,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: blackShade,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              googleLogo,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 10),
            Text('Login with Google'),
          ],
        ),
      ),
    );
  }
}
