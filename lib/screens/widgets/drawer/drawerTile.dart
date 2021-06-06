import 'package:flutter/material.dart';
import '../../../core/myFonts.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPress;

  const DrawerTile({
    @required this.icon,
    @required this.title,
    @required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: ListTile(
        leading: Icon(
          icon,
          // color: Colors.black,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: englishText,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
