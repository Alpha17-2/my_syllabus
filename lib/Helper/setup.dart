import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addNewUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection(uid);
  users.add({'Demo Data': 'null'});
}
