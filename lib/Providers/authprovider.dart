import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authprovider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentuser => auth.currentUser;

  bool get isauthenticated => currentuser != null;

  Future<void> Login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } catch (e) {
      print("failed login $e");
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      print("Registration failed: $e");
      rethrow;
    }
  }
}
