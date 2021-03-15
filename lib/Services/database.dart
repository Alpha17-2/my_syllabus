import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataService {
  final String uid;
  DataService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
}
