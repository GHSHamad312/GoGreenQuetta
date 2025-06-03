import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/screens/app/navmain.dart';
import 'package:greenbus_frontend/screens/auth/Loginscreen.dart';

class Authverify extends StatelessWidget {
  const Authverify({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomeMain();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
