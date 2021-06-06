import 'package:flutter/material.dart';
import '../../../core/myFonts.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;

  const TextContainer({
    @required this.text,
    @required this.size,
    @required this.weight,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontFamily: englishText,
          fontSize: size,
          fontWeight: weight,
        ),
        softWrap: true,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
