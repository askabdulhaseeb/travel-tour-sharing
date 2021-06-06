import 'package:flutter/material.dart';
import '../../../core/myAppName.dart';
import '../../../core/myColors.dart';
import '../../../core/myPhotos.dart';

AppBar signupAppBar() {
  return AppBar(
    iconTheme: IconThemeData(
      color: greenShade,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Row(
      children: [
        Container(
          height: 30,
          child: Image.asset(appLogo),
        ),
        SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: appName,
        )
      ],
    ),
  );
}
