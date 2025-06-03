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
      rethrow;
    }
  }

  Future<void> Logout() async {
    try {
      await auth.signOut();
    } catch (e) {
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
      rethrow;
    }
  }

  // 👇 New function
  Future<void> changePassword(String newPassword) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }
}
