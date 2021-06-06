import 'package:flutter/material.dart';
import '../../../../core/myFonts.dart';

class NoPlaceSelectedYetWidget extends StatelessWidget {
  final String title;
  const NoPlaceSelectedYetWidget({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.add_location_alt_outlined,
          size: 40,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Text(
                'Add',
                style: TextStyle(fontFamily: englishText),
              ),
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: englishText),
            ),
          ],
        ),
      ],
    );
  }
}
