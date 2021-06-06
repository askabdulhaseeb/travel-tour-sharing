import 'package:flutter/material.dart';
import '../widgets/circularProfileImage.dart';

class ReviewCardWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final double rating;
  final String time;
  final String text;

  const ReviewCardWidget({
    Key key,
    @required this.imageURL,
    @required this.name,
    @required this.rating,
    @required this.time,
    @required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircularProfileImage(imageUrl: imageURL),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text('Rating: $rating'),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, maxLines: 5, overflow: TextOverflow.ellipsis),
          ),
          Row(
            children: [
              Spacer(),
              Text('Rating: $time'),
            ],
          ),
        ],
      ),
    );
  }
}
