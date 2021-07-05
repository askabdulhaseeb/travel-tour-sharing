import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/myAppName.dart';
import '../../core/myColors.dart';
import '../../core/myPhotos.dart';
import '../../database/databaseMethod.dart';
import '../../database/userLocalData.dart';
import '../../models/app_user.dart';
import '../profileScreen/profile_screen.dart';
import 'circularProfileImage.dart';

AppBar homeAppBar(context) {
  return AppBar(
    leadingWidth: 26,
    centerTitle: false,
    iconTheme: IconThemeData(color: greenShade),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          child: Image.asset(appLogo),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: appName,
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: () async {
            final DocumentSnapshot docs =
                await DatabaseMethods().getUserInfofromFirebase(
              UserLocalData.getUserUID(),
            );
            AppUser _user = AppUser.fromDocument(docs);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileScreen(user: _user),
            ));
          },
          child: CircularProfileImage(
            imageUrl: UserLocalData.getUserImageUrl(),
          ),
        ),
      ),
    ],
  );
}
