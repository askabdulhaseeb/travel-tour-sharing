import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/database/userLocalData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportProblemMethods {
  static const String _collection = 'report_problem';
  submitReport(String text) async {
    await FirebaseFirestore.instance.collection(_collection).add({
      'uid': UserLocalData.getUserUID(),
      'text': text.trim(),
      'time': Timestamp.now(),
    }).catchError((e) {
      Fluttertoast.showToast(
        msg: 'Report Submission issue, try again',
        backgroundColor: Colors.red,
      );
    });
  }
}
