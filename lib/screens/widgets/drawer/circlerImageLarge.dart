import 'package:flutter/material.dart';
import '../../../core/myPhotos.dart';

class CirclerImageLarge extends StatelessWidget {
  final String imageUrl;

  const CirclerImageLarge({
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    final double _radius = 54.0;
    return CircleAvatar(
      radius: _radius,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: _radius - 2,
        child: CircleAvatar(
          radius: _radius - 6,
          backgroundColor: Theme.of(context).iconTheme.color,
          onBackgroundImageError: (_, stackTrace) {
            AssetImage(appIcon);
          },
          backgroundImage:
              (imageUrl == null || imageUrl == '' || imageUrl.isEmpty)
                  ? AssetImage(appIcon)
                  : NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
