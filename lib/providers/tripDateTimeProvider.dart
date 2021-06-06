import 'package:flutter/material.dart';

class TripDate {
  String _date;
  String _month;
  String _year;
  String _formatedDate;
  TripDate({
    String date,
    String month,
    String year,
    String formatedDate,
  })  : this._date = date,
        this._month = month,
        this._year = year,
        this._formatedDate = formatedDate;
  void setDate(String date) => this._date = date;
  void setMonth(String month) => this._month = month;
  void setYear(String year) => this._year = year;
  void setFormatedDate(String formatedDate) =>
      this._formatedDate = formatedDate;
  String getDate() => this._date;
  String getMonth() => this._month;
  String getYear() => this._year;
  String getFormatedDate() => this._formatedDate;
}

class TripTime {
  String _hour;
  String _minute;
  String _formatedTime;

  TripTime({
    String hour,
    String minute,
    String formatedTime,
  })  : this._hour = hour,
        this._minute = minute,
        this._formatedTime = formatedTime;

  void setHour(String hour) => this._hour = hour;
  void setMinute(String minute) => this._minute = minute;
  void setFormatedTime(String formatedTime) =>
      this._formatedTime = formatedTime;

  String getHour() => this._hour;
  String getMinute() => this._minute;
  String getFormatedTime() => this._formatedTime;
}

class TripDateTimeProvider extends ChangeNotifier {
  TripDate startingDate;
  TripDate endingDate;
  TripTime departureTime;
  TripTime returnTime;

  void updateTripStartingDate({@required TripDate tripDate}) {
    startingDate = tripDate;
    notifyListeners();
  }

  void updateTripEndingDate({@required TripDate tripDate}) {
    endingDate = tripDate;
    notifyListeners();
  }

  void updateTripDepartureTime({@required TripTime tripTime}) {
    departureTime = tripTime;
    notifyListeners();
  }

  void updateTripReturnTime({@required TripTime tripTime}) {
    returnTime = tripTime;
    notifyListeners();
  }
}
