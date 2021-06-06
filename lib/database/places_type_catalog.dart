import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlacesTypeCatalogMethods {
  static const _fPlacesCatalog = 'placesTypeCatalog';
  getAllPlacesCatalog() async {
    return await FirebaseFirestore.instance.collection(_fPlacesCatalog).get();
  }

  getSpecificTypeInfo({@required String id}) async {
    return await FirebaseFirestore.instance
        .collection(_fPlacesCatalog)
        .doc(id)
        .get();
  }
}
