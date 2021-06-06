import 'dart:convert';

import 'package:flutter/material.dart';

class Place {
  String _placeID;
  String _placeName;
  double _rating;
  List<String> _types;
  double _latitude;
  double _longitude;
  String _placesFormattedAddrees;
  String _imageUrl;
  List<Map<String, dynamic>> _reviews;

  Place({
    String id,
    String name,
    double rating,
    List<String> types,
    double lat,
    double long,
    String address,
    String imageUrl,
    List<Map<String, dynamic>> reviews,
  })  : this._placeID = id,
        this._placeName = name,
        this._rating = rating,
        this._types = types,
        this._latitude = lat,
        this._longitude = long,
        this._placesFormattedAddrees = address,
        this._imageUrl = imageUrl,
        this._reviews = reviews;
  //
  //Setters
  //
  void setPlaceID(String id) => this._placeID = id;
  void setPlaceName(String name) => this._placeName = name;
  void setPlaceRating(double rating) => this._rating = rating;
  void setPlaceType(List<String> types) => this._types = types;
  void setPlaceLatitude(double lat) => this._latitude = lat;
  void setPlaceLongitude(double long) => this._longitude = long;
  void setPlaceFormattedAddress(String address) =>
      this._placesFormattedAddrees = address;
  void setPlaceImageUrl(String url) => this._imageUrl = url;
  void setPlaceReviews(List<Map<String, dynamic>> reviews) =>
      this._reviews = reviews;

  //
  //Getters
  //
  String getPlaceID() => this._placeID;
  String getPlaceName() => this._placeName;
  double getPlaceRating() => this._rating;
  List<String> getPlaceTypes() => this._types;
  double getPlaceLatitude() => this._latitude;
  double getPlaceLongitude() => this._longitude;
  String getPlaceFormattedAddress() => this._placesFormattedAddrees;
  String getPlaceImageUrl() => this._imageUrl;
  List<Map<String, dynamic>> getPlaceReviews() => this._reviews;

  Map<String, dynamic> toMap() {
    return {
      'place_id': _placeID ?? '',
      'name': _placeName ?? '',
      'rating': _rating ?? 0,
      'types': _types ?? [],
      'lat': _latitude ?? 0.0,
      'lng': _longitude ?? 0.0,
      'formatted_address': _placesFormattedAddrees ?? '',
      'image_url': _imageUrl ?? '',
      'reviews': _reviews ?? [],
    };
  }

  factory Place.fromDocument(docs) {
    return Place(
      id: docs?.data()['place_id'] ?? '',
      name: docs?.data()['name'] ?? '',
      rating: docs?.data()['rating'] ?? 0,
      types: List<String>.from(docs?.data()['types'] ?? []) ?? [],
      lat: docs?.data()['lat'] ?? 0.0,
      long: docs?.data()['lng'] ?? 0.0,
      address: docs?.data()['formatted_address'] ?? '',
      imageUrl: docs?.data()['image_url'] ?? '',
      // reviews: List<Map<String, dynamic>>.from(
      //         docs?.data()['reviews']?.map((x) => x ?? {})) ??[],
      reviews: [],
    );
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['place_id'],
      name: map['name'],
      rating: map['rating'],
      types: List<String>.from(map['types']),
      lat: map['lat'],
      long: map['lng'],
      address: map['formatted_address'],
      imageUrl: map['image_url'],
      reviews: List<Map<String, dynamic>>.from(map['reviews']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));
}

class PlacesProvider extends ChangeNotifier {
  Place startingPoint;
  Place endingPoint;

  void updateStartingPoint(Place place) {
    startingPoint = place;
    notifyListeners();
  }

  void updateEndingPoint(Place place) {
    endingPoint = place;
    notifyListeners();
  }
}
