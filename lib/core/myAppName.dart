import 'package:flutter/material.dart';
import 'myColors.dart';
import 'myFonts.dart';

Text _firstName = Text(
  'Tour&Travel',
  style: TextStyle(
    color: greenShade,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: englishText,
  ),
);
Text _lastName = Text(
  'Sharing',
  style: TextStyle(
    color: blackShade,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: englishText,
  ),
);

Row appName = Row(
  children: [
    _firstName,
    _lastName,
  ],
);
