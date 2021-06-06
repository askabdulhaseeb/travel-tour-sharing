import 'package:flutter/material.dart';
import '../../../core/myColors.dart';
import '../../../core/myFonts.dart';
import '../loginScreen/loginScreen.dart';

class SignInLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'If you already have an account ',
          style: TextStyle(
            fontSize: 11,
            color: blackShade,
            fontFamily: englishText,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          child: Text(
            'Sign In',
            style: TextStyle(
              color: greenShade,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
