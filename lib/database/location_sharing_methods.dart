import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:geolocator/geolocator.dart';

class LocationSharingMethods {
  static const _fCollection = 'user_location';
  updateUserLocation() async {
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
        .set({'shareWith': shareWith});
  }
}
