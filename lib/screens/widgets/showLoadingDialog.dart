import 'package:flutter/material.dart';

showLoadingDislog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(semanticsLabel: message),
        ),
      );
    },
  );
}
