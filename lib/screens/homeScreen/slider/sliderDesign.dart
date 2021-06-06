import 'package:flutter/material.dart';
import '../../../core/myColors.dart';
import '../../../core/myFonts.dart';

class SliderDesign extends StatelessWidget {
  final String title;
  final String substring;
  final String imageUrl;

  const SliderDesign({
    @required this.title,
    @required this.substring,
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .79,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [greenShade, greenShade, blackShade],
        ),
        boxShadow: [
          BoxShadow(
            color: greenShade.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 1),
          Container(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: englishText,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  substring,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: englishText,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
