import 'package:flutter/material.dart';

class PlanTileHeader extends StatefulWidget {
  final String name;
  PlanTileHeader({@required this.name});
  @override
  _PlanTileHeaderState createState() => _PlanTileHeaderState();
}

class _PlanTileHeaderState extends State<PlanTileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Text(
              widget.name ?? 'Name found issue',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
            padding: const EdgeInsets.all(0),
            splashRadius: 14,
            splashColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
