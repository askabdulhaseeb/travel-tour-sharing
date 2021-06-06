import 'package:flutter/material.dart';
import '../../core/myFonts.dart';
import '../../core/myPhotos.dart';
import '../../providers/placesproviders.dart';
import '../placeDeatilScreen/review_card_wirget.dart';
import '../widgets/homeAppBar.dart';

class PlaceDetailScreen extends StatefulWidget {
  static final routeName = '/PlaceDetailsScreen';
  final Place place;
  const PlaceDetailScreen({this.place});
  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  void initState() {
    print(widget.place.getPlaceReviews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.place.getPlaceID(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (widget.place.getPlaceImageUrl() == null ||
                          widget.place.getPlaceImageUrl().isEmpty)
                      ? AssetImage(appLogo)
                      : NetworkImage(widget.place.getPlaceImageUrl()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.place?.getPlaceName() == null)
                      ? 'Name Not Found'
                      : widget.place.getPlaceName(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: englishText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text('Rating: ${widget.place?.getPlaceRating()}'),
                    Icon(Icons.star_rate_rounded),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.place?.getPlaceFormattedAddress(),
                ),
              ],
            ),
          ),
          Flexible(
            // fit: FlexFit.tight,
            child: (widget?.place?.getPlaceReviews()?.length == 0)
                ? Center(
                    child: Text(
                      'No Review Available',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget?.place?.getPlaceReviews()?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ReviewCardWidget(
                        imageURL: widget.place?.getPlaceReviews()[index]
                            ['profile_photo_url'],
                        name: widget.place?.getPlaceReviews()[index]
                            ['author_name'],
                        rating: (widget.place?.getPlaceReviews()[index]
                                ['rating'] +
                            0.0),
                        time: widget.place?.getPlaceReviews()[index]
                            ['relative_time_description'],
                        text: widget.place?.getPlaceReviews()[index]['text'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
