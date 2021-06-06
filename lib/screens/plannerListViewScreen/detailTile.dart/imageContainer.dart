import 'package:flutter/material.dart';
import '../../../core/myPhotos.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: (imageUrl == null || imageUrl == '' || imageUrl.isEmpty)
                ? AssetImage(appIcon)
                : NetworkImage(imageUrl),
            fit: BoxFit.cover,
          )),
    );
  }
}
