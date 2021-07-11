import 'dart:async';
import 'package:dummy_project/core/myAPIs.dart';
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
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$placesAPI';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    jsonResults.forEach((place) {
      _nearbyPlaces.add(_jsonToPlaceConvertion(place));
    });
    return _nearbyPlaces;
  }

  setInitialCam() {
    CameraPosition _currentCameraPosition = new CameraPosition(
      target: _origin.position,
      zoom: 14,
    );

    _googleMapController
        .animateCamera(CameraUpdate?.newCameraPosition(_currentCameraPosition));
  }

  _initPage() async {
    _origin = _getMarker(widget.place[widget.plan?.departurePlaceID]);
    _destination = _getMarker(widget.place[widget.plan?.destinationPlaceID]);
    _nearbyPlaces = await getNearbyPlaces(
      widget.place[widget.plan?.departurePlaceID].getPlaceLatitude(),
      widget.place[widget.plan?.departurePlaceID].getPlaceLongitude(),
      'abba',
    );
    _nearbyPlaces.forEach((place) {
      _pitPointMarkers.add(_getPitPointMarker(place));
    });
    _getDuration();
    setInitialCam();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          markers: {
            if (_origin != null) _origin,
            if (_destination != null) _destination,
            if (_pitPointMarkers[0] != null) _pitPointMarkers[0],
            if (_pitPointMarkers[1] != null) _pitPointMarkers[1],
            if (_pitPointMarkers[2] != null) _pitPointMarkers[2],
            if (_pitPointMarkers[3] != null) _pitPointMarkers[3],
            if (_pitPointMarkers[4] != null) _pitPointMarkers[4],
            if (_pitPointMarkers[5] != null) _pitPointMarkers[5],
          },
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
