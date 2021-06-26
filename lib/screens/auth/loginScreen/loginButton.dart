import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../auth/authorisation.dart';
import '../../../core/myColors.dart';
import '../../../database/databaseMethod.dart';
import '../../../models/app_user.dart';
import '../../allPlacesTypeScreen/all_places_type_screeen.dart';
import '../../planFeedScreen/plans_feed_screen.dart';
import '../../widgets/showLoadingDialog.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required GlobalKey<FormState> loginFormkey,
    @required TextEditingController email,
    @required TextEditingController password,
  })  : _loginFormkey = loginFormkey,
        _email = email,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _loginFormkey;
  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_loginFormkey.currentState.validate()) {
          TextInput.finishAutofillContext();
          showLoadingDislog(context, 'Loading data');
          User _user = await AuthMethods().loginWithEmailAndPassword(
            _email.text.trim(),
            _password.text.trim(),
          );
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
        }
      },
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [greenShade, greenShade],
          ),
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
