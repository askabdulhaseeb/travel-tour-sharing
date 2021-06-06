import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Plan {
  String planID;
  String uid;
  String planName;
  String departurePlaceID;
  String destinationPlaceID;
  List<String> planType;
  bool isPublic;
  int likes;
  double budget;
  Timestamp timeStemp;
  String departureTime;
  String destinationTime;
  String departureDate;
  String returnDate;
  Plan({
    @required this.planID,
    @required this.uid,
    @required this.planName,
    @required this.departurePlaceID,
    @required this.destinationPlaceID,
    @required this.planType,
    @required this.isPublic,
    @required this.likes,
    @required this.budget,
    @required this.timeStemp,
    @required this.departureTime,
    @required this.destinationTime,
    @required this.departureDate,
    @required this.returnDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'planID': planID ?? '',
      'uid': uid ?? '',
      'planName': planName ?? '',
      'departurePlaceID': departurePlaceID ?? '',
      'destinationPlaceID': destinationPlaceID ?? '',
      'planType': planType ?? [],
      'isPublic': isPublic ?? true,
      'likes': likes ?? 0,
      'budget': budget ?? 0,
      'timeStemp': timeStemp.millisecondsSinceEpoch,
      'departureTime': departureTime ?? '',
      'destinationTime': destinationTime ?? '',
      'departureDate': departureDate ?? '',
      'returnDate': returnDate ?? '',
    };
  }

  factory Plan.fromDocument(docs) {
    return Plan(
      planID: docs?.data()['planID'] ?? '',
      uid: docs?.data()['uid'] ?? '',
      planName: docs?.data()['planName'] ?? '',
      departurePlaceID: docs?.data()['departurePlaceID'] ?? '',
      destinationPlaceID: docs?.data()['destinationPlaceID'] ?? '',
      planType: List<String>.from(docs?.data()['planType'] ?? []),
      isPublic: docs?.data()['isPublic'] ?? true,
      likes: docs?.data()['likes'] ?? 0,
      budget: docs?.data()['budget'] ?? 0,
      timeStemp: Timestamp.fromMillisecondsSinceEpoch(
          docs?.data()['timeStemp'] ?? DateTime.now()),
      departureTime: docs?.data()['departureTime'] ?? '',
      destinationTime: docs?.data()['destinationTime'] ?? '',
      departureDate: docs?.data()['departureDate'] ?? '',
      returnDate: docs?.data()['returnDate'] ?? '',
    );
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      planID: map['planID'],
      uid: map['uid'],
      planName: map['planName'],
      departurePlaceID: map['departurePlaceID'],
      destinationPlaceID: map['destinationPlaceID'],
      planType: map['planType'],
      isPublic: map['isPublic'],
      likes: map['likes'],
      budget: map['budget'],
      timeStemp: Timestamp.fromMillisecondsSinceEpoch(map['timeStemp']),
      departureTime: map['departureTime'],
      destinationTime: map['destinationTime'],
      departureDate: map['departureDate'],
      returnDate: map['returnDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plan &&
        other.uid == uid &&
        other.planName == planName &&
        other.departurePlaceID == departurePlaceID &&
        other.destinationPlaceID == destinationPlaceID &&
        other.planType == planType &&
        other.isPublic == isPublic &&
        other.likes == likes &&
        other.budget == budget &&
        other.timeStemp == timeStemp &&
        other.departureTime == departureTime &&
        other.destinationTime == destinationTime &&
        other.departureDate == departureDate &&
        other.returnDate == returnDate;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        planName.hashCode ^
        departurePlaceID.hashCode ^
        destinationPlaceID.hashCode ^
        planType.hashCode ^
        isPublic.hashCode ^
        likes.hashCode ^
        budget.hashCode ^
        timeStemp.hashCode ^
        departureTime.hashCode ^
        destinationTime.hashCode ^
        departureDate.hashCode ^
        returnDate.hashCode;
  }

  @override
  String toString() {
    return 'Plan(uid: $uid, planName: $planName, departurePlaceID: $departurePlaceID, destinationPlaceID: $destinationPlaceID, planType: $planType, isPublic: $isPublic, likes: $likes, budget: $budget, timeStemp: $timeStemp, departureTime: $departureTime, destinationTime: $destinationTime, departureDate: $departureDate, returnDate: $returnDate)';
  }
}
