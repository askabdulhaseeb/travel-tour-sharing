import 'package:flutter/material.dart';
import 'myColors.dart';
import 'myFonts.dart';

Text safar = Text(
  'Tour&Travel',
  style: TextStyle(
    color: greenShade,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: englishText,
  ),
);
Text kar = Text(
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
    safar,
    kar,
  ],
);
