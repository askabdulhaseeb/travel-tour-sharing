import 'package:flutter/material.dart';
import '../../core/myPhotos.dart';

class CircularProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircularProfileImage({
    @required this.imageUrl,
    this.radius = 24.0,
  });
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: radius - 2,
        child: CircleAvatar(
          radius: radius - 6,
          backgroundColor: Theme.of(context).iconTheme.color,
          backgroundImage:
              (imageUrl == null || imageUrl == '' || imageUrl.isEmpty)
                  ? AssetImage(appIcon)
                  : NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
