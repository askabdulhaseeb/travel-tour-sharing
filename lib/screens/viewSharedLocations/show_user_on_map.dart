import 'dart:async';

import 'package:dummy_project/database/userLocalData.dart';
import 'package:dummy_project/models/app_user.dart';
import 'package:dummy_project/screens/widgets/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowUserLocationOnMap extends StatefulWidget {
  final AppUser user;
  final double lat;
  final double lng;
  const ShowUserLocationOnMap({
    Key key,
    @required this.user,
    @required this.lat,
    @required this.lng,
  }) : super(key: key);
  @override
  _ShowUserLocationOnMapState createState() => _ShowUserLocationOnMapState();
}

class _ShowUserLocationOnMapState extends State<ShowUserLocationOnMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Position _currentPosition;
  GoogleMapController _googleMapController;
  Completer<GoogleMapController> _completer = Completer();
  Marker _currentUserMarker, _otherUserMarker;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );

  // _getUserCurrentLocation() async {
  //   _currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  setInitialCam() {
    CameraPosition _currentCameraPosition = new CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 14,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
  }

  Marker _getMarker({
    @required String uid,
    @required String name,
    @required double lat,
    @required double lng,
  }) {
    return Marker(
      markerId: MarkerId(uid),
      infoWindow: InfoWindow(title: name),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(lat, lng),
    );
  }

  _initPage() async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _otherUserMarker = _getMarker(
      uid: widget.user.uid,
      name: widget.user.displayName,
      lat: widget.lat,
      lng: widget.lng,
    );
    _currentUserMarker = _getMarker(
      uid: UserLocalData.getUserUID(),
      name: UserLocalData.getUserDisplayName(),
      lat: _currentPosition.latitude,
      lng: _currentPosition.longitude,
    );
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: GoogleMap(
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
          // _getUserCurrentLocation();
          setInitialCam();
        },
        markers: {
          if (_otherUserMarker != null) _otherUserMarker,
          if (_currentUserMarker != null) _currentUserMarker,
        },
      ),
    );
  }
}
