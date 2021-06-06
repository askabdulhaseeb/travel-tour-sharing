import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/placesproviders.dart';

class PlacesMethods {
  storePlaceInfoInFirebase(Place place) {
    // Map<String, dynamic> _placeMap = {
    //   'place_id': place.getPlaceID(),
    //   'name': place.getPlaceName(),
    //   'image_url': place.getPlaceImageUrl(),
    //   'lat': place.getPlaceLatitude(),
    //   'lng': place.getPlaceLongitude(),
    //   'rating': place.getPlaceRating(),
    //   'formatted_address': place.getPlaceFormattedAddress(),
    //   'types': place.getPlaceTypes(),
    //   'reviews': place.getPlaceReviews()
    // };
    Map<String, dynamic> _placeMap = place.toMap();
    FirebaseFirestore.instance
        .collection('places')
        .doc(place.getPlaceID())
        .set(_placeMap)
        .catchError((Object obj) {
      print(obj.toString());
    });
  }

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
