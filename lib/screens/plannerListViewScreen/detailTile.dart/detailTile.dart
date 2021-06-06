import 'package:flutter/material.dart';
import '../../../database/userLocalData.dart';
import './timeContainer.dart';
import './textContainer.dart';
import 'imageContainer.dart';

class DetailTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: TimeContainer(time: 'position'),
          ),
          Expanded(
            flex: 1,
            child: Radio(
              value: null,
              groupValue: null,
              onChanged: (_) {},
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextContainer(
                      text: '_place[0].name',
                      size: 14,
                      weight: FontWeight.bold),
                  SizedBox(height: 6),
                  TextContainer(
                    text:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy...',
                    size: 12,
                    weight: FontWeight.normal,
                  ),
                  SizedBox(height: 6),
                  ImageContainer(imageUrl: UserLocalData.getUserImageUrl()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
