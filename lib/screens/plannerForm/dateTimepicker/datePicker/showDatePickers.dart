import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/myColors.dart';
import '../../../../providers/tripDateTimeProvider.dart';
import '../dateOrTimeButtonWidget.dart';
import 'widgets/datepickerWidget.dart';
import 'widgets/showSelectedDate.dart';

class ShowDatePickers extends StatefulWidget {
  @override
  _ShowDatePickersState createState() => _ShowDatePickersState();
}

class _ShowDatePickersState extends State<ShowDatePickers> {
  DateTime _startingDate = DateTime.now();
  DateTime _endingDate = DateTime.now();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (Provider.of<TripDateTimeProvider>(context).startingDate == null)
              ? InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: greenShade,
                  onTap: () {
                    showStatingCupertinoModalPopup(context);
                  },
                  onLongPress: () {
                    showStatingCupertinoModalPopup(context);
                  },
                  child: DateOrTimeButtonWidget(
                    title: 'Dept. Date',
                    icon: Icons.date_range_outlined,
                  ),
                )
              : ShowSelectedDate(
                  date: Provider.of<TripDateTimeProvider>(context).startingDate,
                  onClick: showStatingCupertinoModalPopup,
                ),
          const Icon(Icons.arrow_forward_rounded),
          (Provider.of<TripDateTimeProvider>(context).endingDate == null)
              ? InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: greenShade,
                  onTap: () {
                    if (Provider.of<TripDateTimeProvider>(context,
                                listen: false)
                            .startingDate ==
                        null) {
                      Fluttertoast.showToast(
                        msg: 'Select Starting Date First',
                        backgroundColor: Colors.red,
                        timeInSecForIosWeb: 3,
                      );
                    } else {
                      showEndingCupertinoModalPopup(context);
                    }
                  },
                  onLongPress: () {
                    if (Provider.of<TripDateTimeProvider>(context,
                                listen: false)
                            .startingDate ==
                        null) {
                      Fluttertoast.showToast(
                        msg: 'Select Starting Date First',
                        backgroundColor: Colors.red,
                        timeInSecForIosWeb: 3,
                      );
                    } else {
                      showEndingCupertinoModalPopup(context);
                    }
                  },
                  child: DateOrTimeButtonWidget(
                    title: 'Return Date',
                    icon: Icons.date_range_outlined,
                  ),
                )
              : ShowSelectedDate(
                  date: Provider.of<TripDateTimeProvider>(context).endingDate,
                  onClick: showEndingCupertinoModalPopup,
                )
        ],
      ),
    );
  }

  Future showEndingCupertinoModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          DatePickerWidget(onClick: _updateEndingDate),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Done'),
          onPressed: () {
            if (_endingDate.isAfter(_startingDate) ||
                _endingDate.isAtSameMomentAs(_startingDate)) {
              (_endingDate == null) ??
                  setState(() {
                    _endingDate = DateTime.now();
                  });
              _onDoneEndingDate(_endingDate, context);
              Navigator.of(context).pop();
            } else {
              Fluttertoast.showToast(
                msg: 'Return Date should be grater then Dept. Date',
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 4,
              );
            }
          },
        ),
      ),
    );
  }

  Future showStatingCupertinoModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          DatePickerWidget(onClick: _updateStartingDate),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Done'),
          onPressed: () {
            (_startingDate == null) ??
                setState(() {
                  _startingDate = DateTime.now();
                });
            _onDoneStartingDate(_startingDate, context);
            if (_startingDate.isAfter(_endingDate)) {
              Provider.of<TripDateTimeProvider>(context, listen: false)
                  .updateTripEndingDate(tripDate: null);
            } else {}
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  _updateStartingDate(DateTime dateTime) {
    setState(() {
      _startingDate = dateTime;
    });
  }

  _updateEndingDate(DateTime dateTime) {
    setState(() {
      _endingDate = dateTime;
    });
  }

  TripDate _getTripDateObject(DateTime dateTime) {
    TripDate _tripDate = TripDate();
    final date = DateFormat('dd').format(dateTime);
    final month = DateFormat('MM').format(dateTime);
    final year = DateFormat('yyyy').format(dateTime);

    _tripDate.setDate(date);
    _tripDate.setMonth(month);
    _tripDate.setYear(year);
    _tripDate.setFormatedDate('$date/$month/$year');
    return _tripDate;
  }

  void _onDoneStartingDate(DateTime dateTime, BuildContext context) {
    TripDate _tripDate = _getTripDateObject(dateTime);
    Provider.of<TripDateTimeProvider>(context, listen: false)
        .updateTripStartingDate(tripDate: _tripDate);
  }

  void _onDoneEndingDate(DateTime dateTime, BuildContext context) {
    TripDate _tripDate = _getTripDateObject(dateTime);
    Provider.of<TripDateTimeProvider>(context, listen: false)
        .updateTripEndingDate(tripDate: _tripDate);
  }
}
