import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../core/myAPIs.dart';
import '../../database/placesMethods.dart';
import '../../models/location/placesPreditions.dart';
import '../../providers/placesproviders.dart';
import 'requestAssistants.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, BuildContext context, bool isStartingPoint) async {
    String placeAddress;
    print(position.latitude);
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$placesAPI';

    var responce = await RequestAssistants.getRequest(url);
    if (responce != null) {
      String _cityName =
          responce['results'][0]['address_components'][3]['long_name'];
      String _provinceName =
          responce['results'][0]['address_components'][4]['long_name'];
      String _cuntryName =
          responce['results'][0]['address_components'][5]['long_name'];

      placeAddress = _cityName + ', ' + _provinceName + ', ' + _cuntryName;
      String _placeID = responce["results"][0]["place_id"];

      Place place = Place(
        id: _placeID,
        name: _cityName,
        address: placeAddress,
        lat: position.latitude,
        long: position.longitude,
      );
      // final provider = Provider.of<PlacesProvider>(context, listen: false);
      // provider.updateStartingPoint(place);
      if (isStartingPoint == true) {
        Provider.of<PlacesProvider>(context, listen: false)
            .updateStartingPoint(place);
      } else {
        Provider.of<PlacesProvider>(context, listen: false)
            .updateEndingPoint(place);
      }
    }
    return placeAddress;
  }

  static Future<List<PlacesPreditions>> autoCompletePrediction(
      String name) async {
    if (name.length > 1) {
      // only for PK cities
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$name&key=$placesAPI&sessiontoken=1234567890&components=country:pk';

      var res = await RequestAssistants.getRequest(url);
      if (res != null) {
        if (res['status'] == 'OK') {
          var prediction = res['predictions'];
          List<PlacesPreditions> placesList = (prediction as List)
              .map((json) => PlacesPreditions.fromJason(json))
              .toList();
          return placesList;
        }
      }
      return null;
    }
    return null;
  }

  static String _getPhotoUrlByPhotoReferenceFromAPI(String reference) {
    final String _baseUrl = 'https://maps.googleapis.com/maps/api/place/photo';
    final String _maxWidth = '400';
    final String _maxHeight = '400';
    final String url =
        '$_baseUrl?maxwidth=$_maxWidth&maxheight=$_maxHeight&photoreference=$reference&key=$placesAPI';
    return url;
  }

  // get info from: https://developers.google.com/maps/documentation/places/web-service/details
  static Future<Place> _getPlaceObjectFromAPI(
      String placeID, BuildContext context) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$placesAPI';
    var res = await RequestAssistants.getRequest(url);
    if (res != null) {
      if (res['status'] == 'OK') {
        List<Map<String, dynamic>> lists = [];
        String name, address, imageUrl;
        double lat = 0, lng = 0, rating = 0.0;
        List<String> types;
        Map<String, dynamic> reviews;

        try {
          name = res['result']['name'];
        } catch (e) {
          name = 'Name Not Found';
        }
        try {
          lat = res['result']['geometry']['location']['lat'];
        } catch (e) {
          lat = 0;
        }
        try {
          lng = res['result']['geometry']['location']['lng'];
        } catch (e) {
          lng = 0;
        }
        try {
          address = res['result']['formatted_address'];
        } catch (e) {
          address = 'Address Not Found';
        }
        try {
          String reference = res['result']['photos'][0]['photo_reference'];
          if (reference != null) {
            imageUrl = _getPhotoUrlByPhotoReferenceFromAPI(reference);
          } else {
            imageUrl = '';
          }
        } catch (e) {
          imageUrl = '';
        }
        try {
          rating = (res['result']['rating'] + 0.0);
        } catch (e) {
          rating = 0.0;
        }
        try {
          // TODO: Fetch Reviews

          Map<String, dynamic> mapp = {};
          res['result']['reviews'].forEach((e) {
            mapp = {};
            mapp['author_name'] = e['author_name'];
            mapp['profile_photo_url'] = e['profile_photo_url'];
            mapp['rating'] = e['rating'];
            mapp['relative_time_description'] = e['relative_time_description'];
            mapp['text'] = e['text'];
            lists.add(mapp);
          });
        } catch (e) {
          print(e.toString());
          reviews = {};
        }
        try {
          types = [];
          for (int i = 0; i < res['result']['types'].length; i++) {
            String s = res['result']['types'][i].toString();
            types.add(s);
          }
        } catch (e) {
          print(e.toString());
          types = [];
        }

        Place _place = Place(
          id: placeID,
          name: name,
          address: address,
          imageUrl: imageUrl,
          lat: lat,
          long: lng,
          rating: rating,
          reviews: lists,
          types: types,
        );
        return _place;
      }
    }

    return null;
  }

  static void getStartingPositionFromAPI(
      String placeID, BuildContext context) async {
    Place _place;
    _place = await PlacesMethods().getPlacesObjectFromFirebase(placeID);
    if (_place == null) {
      _place = await _getPlaceObjectFromAPI(placeID, context);
      print('Places Data Fetch From Google API');
    } else {
      print('Places Data Fetch From Firebase');
    }
    if (_place != null) {
      Provider.of<PlacesProvider>(context, listen: false)
          .updateStartingPoint(_place);
      PlacesMethods()?.storePlaceInfoInFirebase(_place);
    }
  }

  static void getEndingPositionFromAPI(
      String placeID, BuildContext context) async {
    Place _place;
    _place = await PlacesMethods().getPlacesObjectFromFirebase(placeID);
    if (_place == null) {
      _place = await _getPlaceObjectFromAPI(placeID, context);
      print('Places Data Fetch From Google API');
    } else {
      print('Places Data Fetch From Firebase');
    }
    if (_place != null) {
      Provider.of<PlacesProvider>(context, listen: false)
          .updateEndingPoint(_place);
      PlacesMethods().storePlaceInfoInFirebase(_place);
    }
  }
}

// get pitpoints by https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&key=YOUR_API_KEY

// Starting from
// https://developers.google.com/maps/documentation/places/web-service/overview
//
// Get Info
// https://developers.google.com/maps/documentation/geocoding/overview
//
// Auto Complete Predicition
// https://developers.google.com/maps/documentation/places/web-service/autocomplete
