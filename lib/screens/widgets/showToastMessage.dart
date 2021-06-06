import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastMessage extends StatefulWidget {
  @override
  _ShowToastMessageState createState() => _ShowToastMessageState();
}

class _ShowToastMessageState extends State<ShowToastMessage> {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    // fToast.showToast(
    //   child: toast,
    //   toastDuration: Duration(seconds: 2),
    //   positionedToastBuilder: (context, child) {
    //     return Positioned(
    //       child: child,
    //       top: 16.0,
    //       left: 16.0,
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          // right: MediaQuery.of(context).size.width / 6,
          child: _showToast(),
        )
      ],
    );
  }
}
