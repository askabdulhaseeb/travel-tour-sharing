import 'package:flutter/material.dart';
import '../../providers/placesproviders.dart';
import '../placeDeatilScreen/placeDetailScreen.dart';
import '../widgets/landscape_image.dart';

class PlaceTimeDetailsCard extends StatelessWidget {
  final Place place;
  final String date;
  final String time;

  const PlaceTimeDetailsCard({
    Key key,
    @required this.place,
    @required this.date,
    @required this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(place: place),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: place?.getPlaceID() ?? '',
            child: LandscapeImageWidget(
              imageUrl: place?.getPlaceImageUrl(),
              height: 180,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 180,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place?.getPlaceName(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Date: $date',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Time: $time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
