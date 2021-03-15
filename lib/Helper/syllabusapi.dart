
import 'package:firebase_core/firebase_core.dart';

import 'auth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

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

signup(String email, String password, AuthNotifier authNotifier,
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


