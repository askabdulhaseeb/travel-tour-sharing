import 'package:flutter/material.dart';

class LoginOrLine extends StatelessWidget {
  const LoginOrLine({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: size.width * 0.30,
          color: Colors.grey,
          child: Text('-'),
        ),
        Text('  OR  '),
        Container(
          height: 1,
          width: size.width * 0.30,
          color: Colors.grey,
          child: Text('-'),
        ),
      ],
    );
  }
}
