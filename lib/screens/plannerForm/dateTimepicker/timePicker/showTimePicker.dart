import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/myColors.dart';
import '../../../../providers/tripDateTimeProvider.dart';
import '../../../../screens/plannerForm/dateTimepicker/timePicker/widgets/showSelectedTime.dart';
import '../dateOrTimeButtonWidget.dart';
import 'widgets/timePickerWidget.dart';

class ShowTimePicker extends StatefulWidget {
  @override
  _ShowTimePickerState createState() => _ShowTimePickerState();
}

class _ShowTimePickerState extends State<ShowTimePicker> {
  DateTime _departureTime = DateTime.now();
  DateTime _returnTime = DateTime.now();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _globalKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (Provider.of<TripDateTimeProvider>(context).departureTime == null)
                ? InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: greenShade,
                    onTap: () {
                      showDepartureCupertinoModalPopup(context);
                    },
                    onLongPress: () {
                      showDepartureCupertinoModalPopup(context);
                    },
                    child: DateOrTimeButtonWidget(
                      title: 'Dept. Time',
                      icon: Icons.timer,
                    ),
                  )
                : Container(
                    child: ShowselectedTime(
                      time: Provider.of<TripDateTimeProvider>(context)
                          .departureTime,
                      onClick: showDepartureCupertinoModalPopup,
                    ),
                  ),
            Icon(Icons.arrow_forward_rounded),
            (Provider.of<TripDateTimeProvider>(context).returnTime == null)
                ? InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: greenShade,
                    onTap: () {
                      showReturnCupertinoModalPopup(context);
                    },
                    onLongPress: () {
                      showReturnCupertinoModalPopup(context);
                    },
                    child: DateOrTimeButtonWidget(
                      title: 'Return Time',
                      icon: Icons.timer,
                    ),
                  )
                : Container(
                    child: ShowselectedTime(
                      time:
                          Provider.of<TripDateTimeProvider>(context).returnTime,
                      onClick: showReturnCupertinoModalPopup,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future showReturnCupertinoModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          TimePickerWidget(onClick: _updateReturnTime),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Done'),
          onPressed: () {
            (_returnTime == null) ??
                setState(() {
                  _returnTime = DateTime.now();
                });
            _onDoneReturnTime(_returnTime, context);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Future showDepartureCupertinoModalPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          TimePickerWidget(onClick: _updateDepartureTime),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Done'),
          onPressed: () {
            (_departureTime == null) ??
                setState(() {
                  _departureTime = DateTime.now();
                });
            _onDoneDepartureTime(_departureTime, context);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  TripTime _getTripTimeObject(DateTime dateTime) {
    TripTime _tripTime = TripTime();
    final hour = DateFormat('hh').format(dateTime);
    final minute = DateFormat('mm').format(dateTime);
    final aa = DateFormat('a').format(dateTime);
    final formatedTime = hour + ':' + minute + ' ' + aa;

    _tripTime.setHour(hour);
    _tripTime.setMinute(minute);
    _tripTime.setFormatedTime(formatedTime);
    return _tripTime;
  }

  void _updateReturnTime(DateTime dateTime) {
    setState(() {
      _returnTime = dateTime;
    });
  }

  void _updateDepartureTime(DateTime dateTime) {
    setState(() {
      _departureTime = dateTime;
    });
  }

  void _onDoneReturnTime(DateTime dateTime, BuildContext context) {
    TripTime _tripTime = _getTripTimeObject(dateTime);
    Provider.of<TripDateTimeProvider>(context, listen: false)
        .updateTripReturnTime(tripTime: _tripTime);
  }

  void _onDoneDepartureTime(DateTime dateTime, BuildContext context) {
    TripTime _tripTime = _getTripTimeObject(dateTime);
    Provider.of<TripDateTimeProvider>(context, listen: false)
        .updateTripDepartureTime(tripTime: _tripTime);
  }
}
