import 'dart:async';
import 'package:dummy_project/core/myAPIs.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:dummy_project/screens/widgets/showLoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/myColors.dart';
import '../../../models/directions.dart';
import '../../../models/location/assistantMethods.dart';
import '../../../models/plan.dart';
import '../../../providers/placesproviders.dart';
import 'directions_repository.dart';

class ShowGoogleMap extends StatefulWidget {
  final Plan plan;
  final Map<String, dynamic> place;

  const ShowGoogleMap({
    Key key,
    @required this.plan,
    @required this.place,
  }) : super(key: key);
  @override
  _ShowGoogleMapState createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _googleMapController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Position _currentPosition;
  Marker _origin, _destination;
  Directions _info;
  List<Place> _nearbyPlaces = [];
  List<Marker> _pitPointMarkers = [];
  List<Map<String, dynamic>> _userInteresedSelectableList = [];
  List<Map<String, dynamic>> _otherSelectableList = [];

  Place _jsonToPlaceConvertion(dynamic place) {
    return Place(
      id: place['place_id'] ?? '1234565434567875678',
      name: place['name'] ?? 'Fack Place',
      lat: place['geometry']['location']['lat'] ?? 0.0,
      long: place['geometry']['location']['lng'] ?? 0.0,
      rating: 0.0,
      address: place['formatted_address'] ?? '',
      reviews: [],
      imageUrl: '',
      types: List<String>.from(place['types'] ?? []),
    );
  }

  Future<List<Place>> getNearbyPlaces(
      double lat, double lng, String placeType) async {
    List<Place> _listOfPlace = [];
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$placesAPI';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    jsonResults.forEach((place) {
      _listOfPlace.add(_jsonToPlaceConvertion(place));
    });
    return _listOfPlace;
  }

  setInitialCam() async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            widget.place[widget.plan?.departurePlaceID].getPlaceLatitude(),
            widget.place[widget.plan?.departurePlaceID].getPlaceLongitude(),
          ),
          zoom: 14.0,
        ),
      ),
    );
  }

  _pitPointsOfUserInterest() async {
    _nearbyPlaces.clear();
    List<Place> perPlaceList = await getNearbyPlaces(
      widget.place[widget.plan?.departurePlaceID].getPlaceLatitude(),
      widget.place[widget.plan?.departurePlaceID].getPlaceLongitude(),
      UserLocalData.getUserInterest()[0],
    );
    _nearbyPlaces.addAll(perPlaceList);
    setState(() {});
    _nearbyPlaces.forEach((place) {
      _pitPointMarkers.add(_getPitPointMarker(place));
    });
    setState(() {});
  }

  _setAllMarkers() {
    _pitPointMarkers.clear();
    _pitPointMarkers.add(_origin);
    _pitPointMarkers.add(_destination);
    _nearbyPlaces.forEach((place) {
      _pitPointMarkers.add(_getPitPointMarker(place));
    });
    setState(() {});
  }

  Future<List<Place>> _getPitPointsOfSpecificKeyPoint(String placeType) async {
    List<Place> placeList = await getNearbyPlaces(
      widget.place[widget.plan?.departurePlaceID].getPlaceLatitude(),
      widget.place[widget.plan?.departurePlaceID].getPlaceLongitude(),
      placeType,
    );
    return placeList;
  }

  _setUpdatedPitPoints(String placeType) async {
    if (_userInteresedSelectableList[0]['isSelected'] == true) {
      _nearbyPlaces.clear();
      // UserLocalData.getUserInterest().forEach((placeType) async {
      //   List<Place> _temp = await _getPitPointsOfSpecificKeyPoint(placeType);
      //   _nearbyPlaces.addAll(_temp);
      //   setState(() {});
      // });
      _initSelectableOption();
    } else {
      if (_nearbyPlaces.contains(placeType)) {
        _nearbyPlaces.clear();
        // Future.wait();
        _userInteresedSelectableList.forEach((placeType) async {
          if (placeType['isSelected'] == true) {
            List<Place> _temp =
                await _getPitPointsOfSpecificKeyPoint(placeType['key']);
            _nearbyPlaces.addAll(_temp);
          }
        });
        // _otherSelectableList.forEach((placeType) async {
        //   if (placeType['isSelected'] == true) {
        //     List<Place> _temp =
        //         await _getPitPointsOfSpecificKeyPoint(placeType['key']);
        //     _nearbyPlaces.addAll(_temp);
        //   }
        // });
      } else {
        _nearbyPlaces.addAll(await _getPitPointsOfSpecificKeyPoint(placeType));
      }
    }
    _setAllMarkers();
  }

  _initSelectableOption() {
    _userInteresedSelectableList.clear();
    _otherSelectableList.clear();
    _userInteresedSelectableList.add({'key': 'All', 'isSelected': true});
    UserLocalData.getUserInterest().forEach((interest) {
      _userInteresedSelectableList.add({'key': interest, 'isSelected': false});
    });
    _otherSelectableList.add({'key': 'food', 'isSelected': false});
    _otherSelectableList.add({'key': 'atm', 'isSelected': false});
    _otherSelectableList.add({'key': 'restaurant', 'isSelected': false});
    _otherSelectableList.add({'key': 'taxi_stand', 'isSelected': false});
    _otherSelectableList.add({'key': 'bus_station', 'isSelected': false});
    _otherSelectableList.add({'key': 'bank', 'isSelected': false});
    _otherSelectableList.add({'key': 'hospital', 'isSelected': false});
    _otherSelectableList.add({'key': 'police', 'isSelected': false});
    setState(() {});
  }

  _initPage() async {
    await _pitPointsOfUserInterest();
    _origin = _getMarker(widget.place[widget.plan?.departurePlaceID]);
    _destination = _getMarker(widget.place[widget.plan?.destinationPlaceID]);

    _pitPointMarkers.add(_origin);
    _pitPointMarkers.add(_destination);
    setInitialCam();
    _getDuration();
    _initSelectableOption();
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                key: _scaffoldKey,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                  _googleMapController = controller;
                  setInitialCam();
                },
                markers: Set<Marker>.of(_pitPointMarkers),
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId(widget.plan.planID),
                      color: greenShade,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              if (_info != null)
                Positioned(
                  top: 20.0,
                  left: 60,
                  right: 60,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: greenShade,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Distance: ${_info.totalDistance}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Time: ${_info.totalDuration}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        //
        Container(
          height: 180,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Interested
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interested',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _userInteresedSelectableList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              showLoadingDislog(context, 'message');
                              if (index == 0) {
                                _initSelectableOption();
                                _setAllMarkers();
                              } else {
                                _userInteresedSelectableList[0].update(
                                  'isSelected',
                                  (value) => false,
                                );
                                _userInteresedSelectableList[index].update(
                                  'isSelected',
                                  (value) =>
                                      !_userInteresedSelectableList[index]
                                          ['isSelected'],
                                );
                              }
                              await _setUpdatedPitPoints(
                                  _userInteresedSelectableList[index]['key']);
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 20,
                              ),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: (_userInteresedSelectableList[index]
                                            ['isSelected'] ==
                                        true)
                                    ? Colors.blue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _userInteresedSelectableList[index]['key']
                                    .toString(),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
              // Important
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _otherSelectableList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _userInteresedSelectableList[0].update(
                                'isSelected',
                                (value) => false,
                              );
                              _otherSelectableList[index].update(
                                'isSelected',
                                (value) =>
                                    !_otherSelectableList[index]['isSelected'],
                              );
                              setState(() {});
                            },
                            child: Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 20,
                              ),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: (_otherSelectableList[index]
                                            ['isSelected'] ==
                                        true)
                                    ? Colors.blue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _otherSelectableList[index]['key'].toString(),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Marker _getMarker(Place place) {
    return Marker(
      markerId: MarkerId(place.getPlaceID()),
      infoWindow: InfoWindow(title: place.getPlaceName()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(place.getPlaceLatitude(), place.getPlaceLongitude()),
    );
  }

  Marker _getPitPointMarker(Place place) {
    return Marker(
      markerId: MarkerId(place.getPlaceID()),
      infoWindow: InfoWindow(title: place.getPlaceName()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(place.getPlaceLatitude(), place.getPlaceLongitude()),
    );
  }

  void _getDuration() async {
    final directions = await DirectionsRepository().getDirections(
      origin: _origin.position,
      destination: _destination.position,
    );
    setState(() => _info = directions);
  }
}
