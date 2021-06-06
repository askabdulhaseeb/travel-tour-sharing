import 'package:flutter/material.dart';
import '../../../../models/location/assistantMethods.dart';
import '../../../../models/location/placesPreditions.dart';

import 'predictedPlaceTile.dart';

class SearchEndingPoint extends StatefulWidget {
  static final routeName = 'SearchEndingPoints';
  @override
  _SearchEndingPointState createState() => _SearchEndingPointState();
}

class _SearchEndingPointState extends State<SearchEndingPoint> {
  String value;
  String initialValue;
  List<PlacesPreditions> _placesPreditions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leadingWidth: 16,
        title: Container(
          height: 42,
          child: Center(
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: TextInputType.streetAddress,
              autofocus: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFEEEEEE),
                hintText: 'Where to go',
                hintStyle: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF757575)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                filled: true,
              ),
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                  _onChange(newValue);
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: (_placesPreditions.length == null)
            ? Container()
            : (_placesPreditions.length == 0)
                ? Center(child: Text('No Place Found Yet!'))
                : ListView.separated(
                    itemCount: (_placesPreditions.length == null)
                        ? 0
                        : _placesPreditions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await AssistantMethods.getEndingPositionFromAPI(
                            _placesPreditions[index].place_id,
                            context,
                          );
                          Navigator.of(context).pop();
                        },
                        child: PredictedPlaceTile(
                          placesPreditions: _placesPreditions[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
      ),
    );
  }

  // Run When user enter name of any place
  _onChange(String value) async {
    List<PlacesPreditions> _preditions =
        await AssistantMethods.autoCompletePrediction(value);
    if (_preditions != null) {
      setState(() {
        _placesPreditions = _preditions;
      });
    }
  }
}
