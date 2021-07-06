import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationSharingMethods {
  static const _fCollection = 'user_location';
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
        .set({
      'lat': _currentPosition.latitude,
      'lng': _currentPosition.longitude,
      'time': Timestamp.now(),
      'shareWith': UserLocalData.getShareLocationWith(),
    });
  }

  getCompleteDocOfCurrectUser() async {
    return await FirebaseFirestore.instance
        .collection(_fCollection)
        .doc(UserLocalData.getUserUID())
        .get();
  }

  shareLocationWith(List<String> shareWith) async {
    await FirebaseFirestore.instance
        .collection(_fCollection)
        .doc(UserLocalData.getUserUID())
        .update({'shareWith': shareWith});
  }
}
