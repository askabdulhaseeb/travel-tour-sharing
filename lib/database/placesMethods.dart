import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/placesproviders.dart';

class PlacesMethods {
  Future<Place> getPlacesObjectFromFirebase(String pid) async {
    final DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection("places")
        .doc(pid)
        .get()
        .onError((error, stackTrace) => null);
    if (!docs.exists) return null;
    Place tempPlace = Place.fromDocument(docs);
    return tempPlace;
  }
}
