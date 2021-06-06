import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
            onTap: () {
              // TODO: Forget Password Click
            },
            child: Text('Forget Password?  ')),
      ),
    );
  }
}
