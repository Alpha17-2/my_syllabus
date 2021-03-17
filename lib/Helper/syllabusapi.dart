import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DeviceSize.dart';
import 'auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

login(String email, String password, AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

Future<int> signup(String email, String password, AuthNotifier authNotifier,
    String displayName) async {
  UserCredential authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    await FirebaseAuth.instance.currentUser
        .updateProfile(displayName: displayName);

    User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile();

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      User currentUser = await FirebaseAuth.instance.currentUser;
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  User firebaseUser = await FirebaseAuth.instance.currentUser;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

Future<int> getTotalTopics() {
  User currentUser = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance
      .collection(currentUser.uid.toString())
      .doc()
      .snapshots()
      .length;
}

void AddNdewSubject(BuildContext context) async {
  User currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController mycontroller = TextEditingController();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Add new subject !",
          style: TextStyle(
            fontSize: displayWidth(context) * 0.05,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: TextField(
          controller: mycontroller,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection(currentUser.uid.toString())
                  .doc("All")
                  .collection("list")
                  .doc(mycontroller.text.toString())
                  .set({
                "title": mycontroller.text.toString(),
                "important": false
              });
              Navigator.of(context).pop();
            },
            child: Text("Submit"),
          )
        ],
      );
    },
  );
}

void AddNdewSubtopic(BuildContext context,String topic) async {
  User currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController mycontroller = TextEditingController();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Add new subtopic !",
          style: TextStyle(
            fontSize: displayWidth(context) * 0.05,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: TextField(
          controller: mycontroller,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
               FirebaseFirestore.instance.collection(currentUser.uid.toString()).doc("All").collection("list").doc(topic).collection(topic).doc(mycontroller.text.toString()).set({"title":mycontroller.text.toString(),"complete":false});
              
              Navigator.pop(context);
            },
            child: Text("Submit"),
          )
        ],
      );
    },
  );
}
