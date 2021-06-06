import 'package:flutter/material.dart';
import '../core/myPhotos.dart';

class Trip {
  final String title;
  final String subtitle;
  final String imageUrl;

  const Trip({
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
  });
}

class TripTypeProvider extends ChangeNotifier {
  List<Trip> _trip = [
    Trip(
      title: 'Friends and Family',
      subtitle: "What's life without friends, right?",
      imageUrl: familyTripPath,
    ),
    Trip(
      title: 'Religious',
      subtitle: "Let's do some meditation...",
      imageUrl: religiousTripPath,
    ),
    Trip(
      title: 'Extreme Sports',
      subtitle: 'Time for some adventure!!',
      imageUrl: sportsTripPath,
    ),
  ];

  List<Trip> get getTrips {
    return [..._trip];
  }
}
