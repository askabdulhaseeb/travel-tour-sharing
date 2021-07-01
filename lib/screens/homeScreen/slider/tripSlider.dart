import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../providers/trips.dart';
import './sliderDesign.dart';
import '../selcetTripButton.dart';

class TripSlider extends StatefulWidget {
  @override
  _TripSliderState createState() => _TripSliderState();
}

class _TripSliderState extends State<TripSlider> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TripTypeProvider _trip = TripTypeProvider();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CarouselSlider(
            items: _trip.getTrips
                .map((trip) => SliderDesign(
                    title: trip.title,
                    substring: trip.subtitle,
                    imageUrl: trip.imageUrl))
                .toList(),
            options: CarouselOptions(
              height: size.height * 0.60,
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          SizedBox(height: size.height * 0.05),
          SelectTripButton(
            currentPage: _current,
          ),
          SizedBox(height: size.height * 0.08),
        ],
      ),
    );
  }
}
