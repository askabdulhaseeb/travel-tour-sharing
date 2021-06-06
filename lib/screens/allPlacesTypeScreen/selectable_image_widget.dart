import 'package:flutter/material.dart';
import '../../models/place_type_catalog.dart';

class SelectableImageWidget extends StatefulWidget {
  final PlacesTypeCatalog placeType;
  final Function onClick;
  final bool isSelected;

  const SelectableImageWidget({
    Key key,
    this.placeType,
    this.onClick,
    this.isSelected,
  }) : super(key: key);
  @override
  _SelectableImageWidgetState createState() => _SelectableImageWidgetState();
}

class _SelectableImageWidgetState extends State<SelectableImageWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  void initState() {
    super.initState();

    controller = AnimationController(
      value: widget.isSelected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
  }

  @override
  void didUpdateWidget(SelectableImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        controller.forward();
      } else {
        controller.reverse();
      }
      widget.onClick(widget.placeType.id, widget.isSelected);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: scaleAnimation.value,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.isSelected ? 80 : 16),
          child: child,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.placeType.imageURL),
              ),
              borderRadius: (widget.isSelected)
                  ? BorderRadius.all(Radius.circular(80.0))
                  : BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: (widget.isSelected)
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.4),
              borderRadius: (widget.isSelected)
                  ? BorderRadius.all(Radius.circular(80.0))
                  : BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Positioned(
            bottom: (widget.isSelected) ? 20 : 10,
            right: 10,
            left: 10,
            child: Center(
              child: Text(
                widget.placeType.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
