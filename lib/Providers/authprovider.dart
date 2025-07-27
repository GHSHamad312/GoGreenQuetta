import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authprovider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool logging = false;

  User? get currentUser => auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  Future<void> login(String email, String password) async {
    logging = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerUser(String email, String password) async {
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

  Future<void> sendVerificationEmail() async {
    final user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> checkEmailVerified() async {
    final user = auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }
}

void sendreset(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    rethrow;
  }
}
