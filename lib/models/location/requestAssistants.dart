import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RequestAssistants {
  static Future<dynamic> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to load album', backgroundColor: Colors.red);
        throw Exception('Failed to load album');
      }
    } catch (exp) {
      Fluttertoast.showToast(msg: exp.toString(), backgroundColor: Colors.red);
      return null;
    }
  }
}
