import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationSharingMethods {
  static const _fCollection = 'user_location';
  updateShareLocationPersons({
    @required bool addNewPerson,
    @required String uid,
  }) async {
    if (addNewPerson == true && uid.isNotEmpty) {
      var doc = await FirebaseFirestore.instance
          .collection(_fCollection)
          .doc(uid)
          .get();
      if (doc.exists) {
        List<String> _canView = List<String>.from(doc?.data()['canView'] ?? []);
        _canView.add(UserLocalData.getUserUID());
        await FirebaseFirestore.instance
            .collection(_fCollection)
            .doc(uid)
            .update({'canView': _canView});
      } else {
        await FirebaseFirestore.instance.collection(_fCollection).doc(uid).set({
          'canView': [UserLocalData.getUserUID()]
        });
      }
      await FirebaseFirestore.instance
          .collection(_fCollection)
          .doc(UserLocalData.getUserUID())
          .update({'shareWith': UserLocalData.getShareLocationWith()});
    } else if (addNewPerson == false && uid.isNotEmpty) {
      var doc = await FirebaseFirestore.instance
          .collection(_fCollection)
          .doc(uid)
          .get();
      if (doc.exists) {
        List<String> _canView = List<String>.from(doc?.data()['canView'] ?? []);
        _canView
            .removeWhere((element) => element == UserLocalData.getUserUID());
        await FirebaseFirestore.instance
            .collection(_fCollection)
            .doc(uid)
            .update({'canView': _canView});
      }
      await FirebaseFirestore.instance
          .collection(_fCollection)
          .doc(UserLocalData.getUserUID())
          .update({'shareWith': UserLocalData.getShareLocationWith()});
    } else {
      Fluttertoast.showToast(msg: 'Some Error', backgroundColor: Colors.red);
    }
  }

  updateUserLocation() async {
    Permission.location.request();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position _currentPosition;
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await FirebaseFirestore.instance
        .collection(_fCollection)
        .doc(UserLocalData.getUserUID())
        .update({
      'lat': _currentPosition.latitude,
      'lng': _currentPosition.longitude,
      'time': Timestamp.now(),
      'shareWith': UserLocalData.getShareLocationWith(),
    });
  }

  setupLocationForNewUser(String uid) async {
    Permission.location.request();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position _currentPosition;
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await FirebaseFirestore.instance.collection(_fCollection).doc(uid).set({
      'lat': _currentPosition.latitude,
      'lng': _currentPosition.longitude,
      'time': Timestamp.now(),
      'shareWith': UserLocalData.getShareLocationWith(),
    });
  }

  // removeLocationSharingWith(String uid) async {
  //   var doc = await FirebaseFirestore.instance
  //       .collection(_fCollection)
  //       .doc(uid)
  //       .get();
  //   if (doc.exists) {
  //     List<String> _canView = List<String>.from(doc?.data()['canView']);
  //     _canView.removeWhere((element) => element == UserLocalData.getUserUID());
  //     await FirebaseFirestore.instance
  //         .collection(_fCollection)
  //         .doc(uid)
  //         .update({'canView': _canView});
  //   }
  // }

  getCompleteDocOfCurrectUser() async {
    return await FirebaseFirestore.instance
        .collection(_fCollection)
        .doc(UserLocalData.getUserUID())
        .get();
  }

  // shareLocationWith(List<String> shareWith) async {
  //   await FirebaseFirestore.instance
  //       .collection(_fCollection)
  //       .doc(UserLocalData.getUserUID())
  //       .update({'shareWith': shareWith});
  // }
}
