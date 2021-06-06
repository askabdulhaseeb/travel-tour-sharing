import 'dart:convert';

import 'package:flutter/material.dart';

class PlacesTypeCatalog {
  final String id;
  final String name;
  final String imageURL;
  PlacesTypeCatalog({
    @required this.id,
    @required this.name,
    @required this.imageURL,
  });

  factory PlacesTypeCatalog.fromDocument(docs) {
    return PlacesTypeCatalog(
      id: docs?.data()['id'].toString(),
      name: docs?.data()['name'].toString(),
      imageURL: docs?.data()['imageURL'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageURL': imageURL,
    };
  }

  factory PlacesTypeCatalog.fromMap(Map<String, dynamic> map) {
    return PlacesTypeCatalog(
      id: map['id'].toString(),
      name: map['name'].toString(),
      imageURL: map['imageURL'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlacesTypeCatalog.fromJson(String source) =>
      PlacesTypeCatalog.fromMap(json.decode(source));
}
