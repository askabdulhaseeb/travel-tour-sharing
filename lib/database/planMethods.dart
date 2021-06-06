import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanMethods {
  static const _fPlan = 'plans';
  getPlansOfSpecificUser({@required String uid}) async {
    return await FirebaseFirestore.instance
        .collection(_fPlan)
        .where('uid', isEqualTo: uid)
        .get();
  }

  getPlanOfSpecificType({@required String type}) async {
    return FirebaseFirestore.instance
        .collection(_fPlan)
        .where('planType', arrayContains: type)
        .snapshots();
  }

  getAllPublicPlans() async {
    return FirebaseFirestore.instance
        .collection(_fPlan)
        .where('isPublic', isEqualTo: true)
        .snapshots();
  }
}
