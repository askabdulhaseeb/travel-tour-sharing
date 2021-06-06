import 'package:flutter/material.dart';
import '../../core/myPhotos.dart';

class LandscapeImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const LandscapeImageWidget({
    @required this.imageUrl,
    this.height = 100,
    this.width = double.infinity,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
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
