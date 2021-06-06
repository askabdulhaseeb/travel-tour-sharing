import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String imageURL;
  final List<String> interest;

  AppUser({
    @required this.uid,
    @required this.displayName,
    @required this.email,
    @required this.phoneNumber,
    @required this.imageURL,
    @required this.interest,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageURL': imageURL,
      'interest': interest,
    };
  }

  factory AppUser.fromDocument(DocumentSnapshot docs) {
    return AppUser(
      uid: docs?.data()['uid'].toString(),
      displayName: docs?.data()['displayName'].toString() ?? '',
      email: docs?.data()['email'].toString() ?? '',
      phoneNumber: docs?.data()['phoneNumber'].toString() ?? '',
      imageURL: docs?.data()['imageURL'].toString() ?? '',
      interest: List<String>.from(docs?.data()['interest'] ?? []) ?? [],
    );
  }
}
