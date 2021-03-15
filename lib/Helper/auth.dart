import 'package:Syllabus/Pages/mySyllabus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authservice {
  // Create an instance of firebase authentication.
  final FirebaseAuth _auth;

  authservice(this._auth);
  //auth is an private property !!

  Stream<User> get authStateChanges => _auth.authStateChanges();

//sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

//sign in with email and password  !!
  Future<String> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = auth.currentUser;
      final uid = user.uid;
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return "Error";
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "SignedUp";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
