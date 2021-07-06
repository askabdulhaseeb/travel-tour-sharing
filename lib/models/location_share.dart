import 'dart:convert';

import 'package:flutter/material.dart';

class LocationShare {
  final List<String> shareWith;
  LocationShare({
    @required this.shareWith,
  });

  Map<String, dynamic> toMap() {
    return {
      'shareWith': shareWith,
    };
  }

  factory LocationShare.fromDocument(docs) {
    return LocationShare(
      shareWith: List<String>.from(docs?.data()['shareWith']),
    );
  }
  factory LocationShare.fromMap(Map<String, dynamic> map) {
    return LocationShare(
      shareWith: List<String>.from(map['shareWith']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationShare.fromJson(String source) =>
      LocationShare.fromMap(json.decode(source));
}
